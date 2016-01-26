# my_pyrad_ddRADseq_steps
just some notes for myself about the steps I work through with ddRADseq data and pyrad. I relied very heavily on the pyRAD tutorials e.g. http://nbviewer.jupyter.org/gist/dereneaton/dc6241083c912519064e/tutorial_pairddRAD_3.0.4-merged.ipynb

1) After logging onto the file transfer infrastructure, I copied the fastq.gz (zipped fastq files) to a temporary storage location e.g. /nfs1/FW_HMSC/Baker_Lab/24Aug2015_GBS_run

2) After establishing an interactive session (qlogin), I installed pyrad (because I know it can handle barcodes of different lengths using the command
```
git clone https://github.com/dereneaton/pyrad.git
```

3) Following the instructions for pyrad (http://nbviewer.ipython.org/gist/dereneaton/af9548ea0e94bff99aa0/pyRAD_v.3.0.ipynb#3.-Input-files) I checked the following dependencies for pyrad were installed in my path automatically (pretty much typed the program names into the command line to see if anything happened):

python, muscle, vsearch

4) vsearch was not installed, so installed it and tested it by doing the following:
```
git clone https://github.com/torognes/vsearch.git
cd ./vsearch/src/
make -f Makefile
cd ../bin/
vsearch-1.1.3-linux-x86_64"
```
I didn't bother adding it to the path yet, because pyrad uses a settings file where you can specify the full pathway to it.

5) pyrad also needed numpy and scipy installed (python libraries), so I checked that these were in the default python installation by:
```
python
import numpy
numpy.version.version
import scipy
scipy.version.version
quit()
```
Because these guys are installed, it spat the following back to me after running the "version.version" commands: '1.9.1' and '0.14.0'

6) After getting all those guys installed, I then went back to the pyrad folder, and tested that everything was hunky dory by running the following:
```
python pyrad/pyRAD.py -h
```
I didn't change it to an executable, because of a lack of sudo privileges, and it runs fine enough just explicitly running it via python like above.

7) I returned to the temporary storage directory (e.g. '/nfs1/FW_HMSC/Baker_Lab/24Aug2015_GBS_run') and made a working directory ('working') usking the mkdir command. Following the instructions for pyrad mentioned at step number 3, I made a barcodes file 

8) I made a dummy params.txt file within the working folder by:
```
python ../../bin/pyrad/pyrad/pyRAD.py
```
(the ../../ blah blah is the relative pathway to the pyRAD.py script from the working folder we are in). I then edited the params.txt file to personalize it to our dataset. Specifically I changed the following options:

--2 (the location of our reads) to: "/nfs1/FW_HMSC/Baker_Lab/24Aug2015_GBS_run/lane3-s023-index--GBS0073_S23_L003_R*_001.fastq.gz" (the * means it will match to R1 and R2)

--3 (the location of our barcode) to: "./barcodes" (the "./" just means, current directory)

--4 (the path to vsearch) to: "/nfs1/FW_HMSC/Baker_Lab/bin/vsearch/bin/vsearch-1.1.3-linux-x86_64"

--6 (our restriction cut overhangs) to: "AGCTT,CGG" (overhang for rare cutter hindIII, followed by overhang for mspI)

--7 (the number of processors - seeing as I was running on an interactive session with only 1 proc) to: 1 (when running as a PBS script, I have jacked this up to 8)

--11 (datatype) to: pairddrad

I left everything else as default, because we aren't running any of the other steps other than demultiplexing right now.

9) I ran pyrad for step one (just the demultiplexing step) by:
```
python ../../bin/pyrad/pyrad/pyRAD.py -p params.txt -s 1
```

10) This unzips the demultiplexed *.fastq.gz files so we can run PEAR on them. I ran it from the parent folder of the fastq folder
(/nfs1/FW_HMSC/Baker_Lab/24Aug2015_GBS_run/working) :
```
for gfile in fastq/*.gz;
  do gunzip $gfile;
done
```

11) Installing PEAR after going to the "bin" directory where I've dumped all the programs we need to use (/nfs1/FW_HMSC/Baker_Lab/bin):
```
wget 'http://sco.h-its.org/exelixis/web/software/pear/files/pear-0.9.6-bin-64.tar.gz'
```
12) Running PEAR on our demultiplexed *.fastq files, again from the parent folder mentioned above:
```
for gfile in fastq/*_R1.fq;
  do /nfs1/FW_HMSC/Baker_Lab/bin/pear-0.9.6-bin-64/pear-0.9.6-bin-64 -f $gfile \
          -r ${gfile/_R1.fq/_R2.fq} \
          -o ${gfile/_R1.fq/} \
          -n 33 >> pear.log 2>&1
done
```
13) I modified the params file (attached) following the instructions of the tutorial (changing type of data to ddrad and also pointing to the assembled files), and then ran pyRAD to filter the assembled data
(disregarding the unassembled guys for now). The -s 2 option is just saying only do step 2 (the filtering step). 
```
python ../../bin/pyrad/pyrad/pyRAD.py -p params_filter.txt -s 2
```

14) I then created a new params file which pointed to the edited, assembled files which resulted from the previous filtering step, and ran pyRAD to do the within-sample clustering step: (http://nbviewer.ipython.org/gist/dereneaton/dc6241083c912519064e/tutorial_pairddRAD_3.0.4-merged.ipynb) with the command:
```
python ../../bin/pyrad/pyrad/pyRAD.py  -p params_cluster.txt -s 3
```

15)  The next steps are calculating error rates across the loci and then calling the consensus sequence. At this step, I bumped up param 8 in the file to what I wanted it to be for the final dataset (e.g. 30 for a high-cov dataset, but at least 10 even for low coverage).
```
python ../../bin/pyrad/pyrad/pyRAD.py  -p params_diversity.txt -s 4
python /nfs1/FW_HMSC/Baker_Lab/bin/pyrad/pyrad/pyRAD.py  -p /nfs1/FW_HMSC/Baker_Lab/24Aug2015_GBS_run/working/params_diversity.txt -s 5
```
