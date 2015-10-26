# pyRAD_alleles_into_structure
This set of scripts parses out pyRAD's allele file into a structure file based on alleles rather than SNPs. It also outputs info on cpmpleteness of the data set and if alleles are shared across populations/species.

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
