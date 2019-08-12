# number_of_hets_per_locus
Originally at: https://github.com/laninsky/number_of_hets_per_locus

Using a folder fill of fasta alignments for a single individual, spits out number of hets per locus

Following the steps at https://github.com/laninsky/pyRAD-fasta-filtering where you've carved up your larger fasta files into folders for each individual containing separate fasta files per locus, perhaps you want to double check diversity levels etc in your dataset to weed out any potentially paralagous loci.

### Usage
het_count.R, het_count.sh and summarize_het.R all have to be in the directory with your fasta files. Execute by:

bash het_count.sh

### Output
You'll get two files: het_count.txt has a list of every locus, the number of heterozygous sites in it, and its total sequence length (just in case you want to track down any pesky loci with large numbers of heterozygous sites etc). summarize_het.txt gives some information on the diversity levels inferred from the fasta files for your individual.

### Version history
These scripts were written for exploratory analyses of RADseq datasets that were not published. I am no longer actively maintaining this repository, but will respond to issues.
