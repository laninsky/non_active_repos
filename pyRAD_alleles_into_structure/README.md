# pyRAD_alleles_into_structure
Originally at: https://github.com/laninsky/pyRAD_alleles_into_structure

This set of scripts parses out pyRAD's allele file into a structure file based on alleles (rather than SNPs), as well as a SNP-based structure file. It also outputs info on completeness of the data set and if alleles are shared across populations/species.

# species_assignments file
This file consists of the sample names in the left-hand column and the species or population assignments in the right-hand column. The scripts will use this file to look at allele sharing across species/populations.
e.g.
```
Chem15NZ35.assembled    hectors
ChecKK063.assembled     hectors
28311.assembled rightwhales
13193.assembled rightwhales
PmaNZ016.assembled      spermwhales
```

# Further downsampling
You can run the pyRAD_alleles_into_structure.sh script after removing samples you don't want to use from your alleles file e.g.
```
grep -v "Chem15NZ35*" c88d6m4p3.alleles > temp
mv c88d6m4p3.alleles original_c88d6m4p3.alleles
mv temp c88d6m4p3.alleles
```
Make sure to tweak your species_assignment file so it matches what is now in your structure file.

Alterately, if you would like to change the proportion of missing data allowed in your structure.txt file, or the taxa included, please follow the instructions at:
https://github.com/laninsky/ambigoos_into_structure#what-if-you-want-to-tweak-the-individuals-in-the-filechange-completeness-of-dataset

To modify the alleles.txt file, do the following steps:
First step: grep everything except the samples you don't want e.g.
```
grep -v "Chem15NZ35*" full_allele_record.txt | grep -v "ChecKK063*" > mod_full_allele_record.txt
```

If you are just high-grading for completeness and don't want to exclude any samples then:
```
cp full_allele_record.txt mod_full_allele_record.txt
```
Second step:
```
Rscript allele_tweaking.R
```

# Version history
These scripts were written for exploratory analyses of RADseq datasets that were never published. I am no longer actively maintaining this repository, but will respond to issues.
