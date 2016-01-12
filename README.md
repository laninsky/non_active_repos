# No_of_pis_per_locus
You might need to filter your UCE data just to retain the most variable loci for *BEAST etc

For a given folder full of your UCE loci as individual nexus alignments, the following R code will spit out a list of your loci, the number of parsimony informative sites (pis), and the length of the locus. 

```
#install phyloch and all its necessary packages (e.g. ape, colorspace, XML)
library(phyloch)
#Change to your working directory

# getting all the files
listoffiles <- list.files(pattern="*.nex*")
nooffiles <- length(listoffiles)

record <- c("locusname","pis","length")

for (j in 1:nooffiles) {
write.table((gsub("?","N",(readLines(listoffiles[j])),fixed=TRUE)),"list_of_pis_by_locus.txt",sep="",quote=FALSE,row.names=FALSE,col.names=FALSE)
tempfile <- read.nex("list_of_pis_by_locus.txt")
templength <- dim(tempfile)[2]
temppis <- pis(tempfile)
temp <- cbind(listoffiles[j],temppis,templength)
record <- rbind(record,temp)
}

write.table(record, "list_of_pis_by_locus.txt",quote=FALSE, row.names=FALSE,col.names=FALSE)

```

You can also use this list to summarize the number of pis in loci across different datasets using the code at: https://github.com/laninsky/comparing_lists

After I've run RAxML on my 'complete' dataset, I then use a modification of the file spat out above to prune the total genetrees file for all the loci, to only the more variable ones. To do this, you need to modify the "list_of_pis_by_locus.txt" to just the first column with the loci names, containing the loci you want to get rid of out of your file (and stripping any file suffixes e.g. 'nexus' from the names). Call this list "remove_list.txt". 

You then need to navigate to your genetrees folder, and run the code at #6 at the following link in order to get a tree file which has the locus names given explicitly:
https://github.com/laninsky/Phase_hybrid_from_next_gen/tree/master/post-processing

After this, running the following code in R should constrain the trees in the file to just those NOT on the remove list.

```
# remove_list.txt is a text file with each locus to remove on a new line (e.g. one column)
tocull <- as.matrix(read.csv("remove_list.txt",header=FALSE))

treefile <- as.matrix(read.table("ubertree.tre",sep=" ",header=FALSE))

output <- treefile[(!(treefile[,1] %in% tocull)),2]

write.table(output, "pitrees.tre", sep="",quote=FALSE, row.names=FALSE,col.names=FALSE)
```

#This pipeline wouldn't be possible without:

R: R Core Team. 2015. R: A language and environment for statistical computing. URL http://www.R-project.org/. R Foundation for Statistical Computing, Vienna, Austria. https://www.r-project.org/

Phyloch and its package dependencies: https://cran.r-project.org/web/packages/ips/citation.html
