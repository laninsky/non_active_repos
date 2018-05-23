input_file <- commandArgs()[1]

print(input_file)
  cat("Rscript filtering_SNPs_by_sample_coverage.R path_and_name_of_file_you_want_to_filter
e.g.
Rscript filtering_SNPs_by_sample_coverage.R results_21merged_trimmedQ20_R1_21merged_trimmedQ20_R2_22merged_trimmedQ20_R1_22merged_trimmedQ20_R2_23merged_trimmedQ20_R1_23merged_trimmedQ20_R2_24merged_trimmedQ20_R1_24merged_trimmedQ20_R2_25merged_trimmedk51_coherents_type_0a.fa")
  input <- read.table(input_file,header = FALSE,sep = "\t")
  to_delete <- NULL

  for (i in seq(1,(dim(input)[1]),4)) {
    # getting the coverage over the samples for the first allele
    sample_coverage_1st <- NULL
    temp1st <- unlist(strsplit(as.character(input[i,1]),"|C",fixed =TRUE))
    for (j in 3:(length(temp1st)-1)) {
      sample_coverage_1st <- c(sample_coverage_1st,unlist(strsplit(temp1st[j],"_",fixed=TRUE))[2])
    }
    sample_coverage_1st <- c(sample_coverage_1st,unlist(strsplit((unlist(strsplit(temp1st[length(temp1st)],"|Q",fixed=TRUE))[1]),"_",fixed=TRUE))[2])
    
    # getting the coverage over the samples for the second allele    
    sample_coverage_2nd <- NULL
    temp2nd <- unlist(strsplit(as.character(input[(i+2),1]),"|C",fixed =TRUE))
    for (j in 3:(length(temp2nd)-1)) {
      sample_coverage_2nd <- c(sample_coverage_2nd,unlist(strsplit(temp2nd[j],"_",fixed=TRUE))[2])
    }
    sample_coverage_2nd <- c(sample_coverage_2nd,unlist(strsplit((unlist(strsplit(temp2nd[length(temp2nd)],"|Q",fixed=TRUE))[1]),"_",fixed=TRUE))[2])
    
    # seeing whether we have at least one individual where at least one allele has > 10 reads. If not printing which SNPs will be deleted
    # and recording the rows to be deleted so we can do this at the end    
    if (!(max(as.numeric(sample_coverage_1st))>=10 | max(as.numeric(sample_coverage_2nd))>=10)) {
      cat(paste("Removing the following SNP due to low coverage:\n",input[i,1],"\n",input[(i+2),1],"\n",sep=""))
      to_delete <- c(to_delete,i:(i+3))
    }    
  }
  output <- input[-to_delete,1]                                           
  write.table(output,"filtered_SNPs.fa",quote=FALSE,col.names=FALSE,row.names=FALSE)
