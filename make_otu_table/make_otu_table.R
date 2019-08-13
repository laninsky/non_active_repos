make_otu_table <- function(fasta_file) {
  # reading in the fasta file
  temp <- readLines(fasta_file)
  # taking just the lines that start with ">"
  temp <- temp[grep(">",temp)]
  outputmatrix <- NULL
  # For each read name beginning with ">" in the fasta file
  for (i in 1:length(temp)) {
    # splitting the line based on "merged_sample={" and just taking the second element of this, because it has all the stuff we are interested in
    temp1 <- unlist(strsplit(temp[i],"merged_sample=\\{"))[2]
    # Further splitting this on "cluster_weight=[[:digit:]]+; cluster=" to roughly get back our sample sites/read counts (temp2[1]) and our OTU (temp2[2])
    temp2 <- unlist(strsplit(temp1,"\\}; cluster_weight=[[:digit:]]+; cluster="))
    # Getting the otuname by removing all the stuff after the OTU ame
    otuname <- gsub("; cluster_score=.*","",temp2[2])
    # Creating a vector, temp2, which has sample site names in the odd positions, and associated reads in the even positions
    temp2 <- unlist(strsplit(temp2[1],":"))
    temp2 <- unlist(strsplit(temp2,","))
    temp2 <- gsub(" ","",temp2)
    temp2 <- gsub("'","",temp2)
    # If the outputmatrix doesn't have any data in it yet
    if (is.null(outputmatrix)) {
      # Creating a matrix that will have OTU names in the left hand column, and sample names in the subsequent columns, based on the number of samples found in the current read
      outputmatrix <- matrix("",ncol=(length(temp2)/2+1),nrow=2)
      # Filling the matrix with our sample names (preceded by a "" as a place-holder for the OTU column)
      outputmatrix[1,] <- c("",temp2[seq(1,length(temp2),2)])
      # Getting in the OTU name and the counts for each sample site
      outputmatrix[2,] <- c(otuname,temp2[seq(2,length(temp2),2)])
    # Or else, if the outputmatrix DOES have data  
    } else {
      # Seeing whether there is an existing row for the OTU the current read is assigned to
      if (!(otuname %in% outputmatrix[,1])) {
        # If not, creating a new row corresponding to that OTU
        outputmatrix <- rbind(outputmatrix,c(otuname,rep.int(0,(dim(outputmatrix)[2]-1))))
      }  
      # Then for each sample that has counts for that read
      for (j in seq(1,length(temp2),2)) {
        # If the sample is not currently in the matrix, adding a column for it
        if (!(temp2[j] %in% outputmatrix[1,])) {
          outputmatrix <- cbind(outputmatrix,c(temp2[j],rep.int(0,(dim(outputmatrix)[1]-1))))
        }
        # For each OTU, for each sample, adding counts associated with the current read to any associated with previously counted reads
        outputmatrix[(which(outputmatrix[,1]==otuname)),(which(outputmatrix[1,]==temp2[j]))] <- as.numeric(outputmatrix[(which(outputmatrix[,1]==otuname)),(which(outputmatrix[1,]==temp2[j]))]) + as.numeric(temp2[j+1])
      }
    }  
  }
  write.table(outputmatrix,"otu_table.csv",quote = FALSE,row.names=FALSE,col.names=FALSE,sep=",")
}
