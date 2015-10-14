# pyRAD-fasta-filtering
Some R scripts I use for dealing with pyRAD output. After I create my *.loci file through pyRAD, I pull that file through:
https://github.com/laninsky/Phase_hybrid_from_next_gen/tree/master/helper_scripts

This creates a folder of fasta files, one per locus. The next steps here are for filtering the loci out into separate folders for each sample, and separate folders per species. To do this, you'll need the species_assignments file that you would have already created for the *.loci > fasta step (but also available at: https://github.com/laninsky/Phase_hybrid_from_next_gen/tree/master/post-processing).

#Filtering for separate folders for each sample

You'll need the species_assignment file and the species_filtering.R files in the directory with all of your fasta files. This step will delete the fasta files which contain all the species, so you might want to back them up in a different location if you want to keep them. Loci will only be written out for each species if there is actually data in them (e.g. if the "sequence" is entirely composed of Ns, it won't be written out).

```
numspecies=`grep -cve '^\s*$' species_assignments`
for ((i=1; i<=$numspecies; i++)); 
do tail -n+$i species_assignments | head -n1 > tempname;
dirname=`awk '{print $2}' tempname`;
mkdir `echo $dirname`;
rm tempname;
done

for i in `ls *.fasta`;
do mv $i temp;
echo $i > tempname;
Rscript species_filtering.R;
rm temp*;
done;
```


