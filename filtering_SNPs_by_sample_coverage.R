#working_dir <- "/Users/alanaalexander/Dropbox/fish"
#input_file <- "results_0.1_type0a_TEST.fa"

filtering_SNPs_by_sample_coverage - function(working_dir,

setwd(working_dir)
input <- read.table(input_file,header = FALSE,sep = "\t")
