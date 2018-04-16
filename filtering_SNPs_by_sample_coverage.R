#working_dir <- "/Users/alanaalexander/Dropbox/fish"
#input_file <- "results_0.1_type0a_TEST.fa"

filtering_SNPs_by_sample_coverage - function(working_dir,

  setwd(working_dir)
  input <- read.table(input_file,header = FALSE,sep = "\t")

  for (i in seq(1,(dim(input)[1]),4)) {
    sample_coverage_1st <- NULL
    temp1st <- unlist(strsplit(as.character(input[i,1]),"|C",fixed =TRUE))
    for (j in 3:(length(temp1st)-1)) {
      sample_coverage_1st <- c(sample_coverage_1st,unlist(strsplit(temp1st[j],"_",fixed=TRUE))[2])
    }
    sample_coverage_1st <- c(sample_coverage_1st,unlist(strsplit((unlist(strsplit(temp1st[length(temp1st)],"|Q",fixed=TRUE))[1]),"_",fixed=TRUE))[2])
      
    print(i)
  }  
