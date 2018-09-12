fasta_file <- "/Users/alanaalexander/Downloads/18S_1_sorted_OTU_table.fasta"



make_otu_table <- function(fasta_file) {
  temp <- readLines(fasta_file)
  temp <- temp[grep(">",temp)]
  outputmatrix <- NULL
  for (i in 1:length(temp)) {
    temp1 <- unlist(strsplit(temp[i],"merged_sample=\\{"))[2]
    temp2 <- unlist(strsplit(temp1,"\\}; cluster_weight=[[:digit:]]+; cluster="))
    otuname <- gsub("; cluster_score=.*","",temp2[2])
  
  
}
