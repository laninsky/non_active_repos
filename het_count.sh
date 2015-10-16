for i in `ls *.fasta`;
do cp $i temp;
echo $i > tempname;
Rscript het_count.R;
rm temp*;
done;
