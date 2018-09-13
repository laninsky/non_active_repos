make_otu_table <- function(fasta_file) {
  temp <- readLines(fasta_file)
  temp <- temp[grep(">",temp)]
  outputmatrix <- NULL
  for (i in 1:length(temp)) {
    temp1 <- unlist(strsplit(temp[i],"merged_sample=\\{"))[2]
    temp2 <- unlist(strsplit(temp1,"\\}; cluster_weight=[[:digit:]]+; cluster="))
    otuname <- gsub("; cluster_score=.*","",temp2[2])
    temp2 <- unlist(strsplit(temp2[1],":"))
    temp2 <- unlist(strsplit(temp2,","))
    temp2 <- gsub(" ","",temp2)
    temp2 <- gsub("'","",temp2)
    if (is.null(outputmatrix)) {
      outputmatrix <- matrix("",ncol=(length(temp2)/2+1),nrow=2)
      outputmatrix[1,] <- c("",temp2[seq(1,length(temp2),2)])
      outputmatrix[2,] <- c(otuname,temp2[seq(2,length(temp2),2)])
    } else {
      if (!(otuname %in% outputmatrix[,1])) {
        outputmatrix <- rbind(outputmatrix,c(otuname,rep.int(0,(dim(outputmatrix)[2]-1))))
      }  
      for (j in seq(1,length(temp2),2)) {
        if (!(temp2[j] %in% outputmatrix[1,])) {
          outputmatrix <- cbind(outputmatrix,c(temp2[j],rep.int(0,(dim(outputmatrix)[1]-1))))
        }
        outputmatrix[(which(outputmatrix[,1]==otuname)),(which(outputmatrix[1,]==temp2[j]))] <- as.numeric(outputmatrix[(which(outputmatrix[,1]==otuname)),(which(outputmatrix[1,]==temp2[j]))]) + as.numeric(temp2[j+1])
      }
    }  
  }
}
