# No_of_pis_per_locus
You might need to filter your UCE data just to retain the most variable loci for *BEAST etc

For a given folder full of your UCE loci as individual phylip alignments, the following R code will spit out a list of your loci, the number of parsimony informative sites (pis), and the length of the locus. 

```
#install phyloch and all its necessary packages (e.g. ape, colorspace, XML)

#Change to your working directory

# getting all the files
listoffiles <- list.files(pattern="*.phy")
nooffiles <- length(listoffiles)

record <- c("locus name","pis","length")

for (j in 1:nooffiles) {
temprow <- as.matrix(read.csv(listoffiles[j],nrow=1,header=FALSE))
templength <- unlist(strsplit(temprow[1,1]," "))[3]
temppis <- pis(read.phy(gsub("?","N",readLines(listoffiles[j]),fixed=TRUE)))
temp <- cbind(listoffiles[j],temppis,templength)
record <- rbind(record,temp)
}

write.table(record, "list_of_pis_by_locus.txt", sep="",quote=FALSE, row.names=FALSE,col.names=FALSE)

```

After I've run RAxML on my 'complete' dataset, I then use a modification of the file spat out above to prune the total genetrees file for all the loci, to only the more variable ones. To do this, you need to modify the "list_of_pis_by_locus.txt" to just the first column with the loci names, containing the loci you want to get rid of out of your file.
```
#getting list of loci to cull (those with < 20 pis). Probably could pipe the output of the other script straight into here, but in the meantime
# it is just after a text file with each locus to remove on a new line (e.g. one column)
tocull <- as.matrix(read.csv("remove_list.txt",header=FALSE))

#reading in the trees: make sure the sep character is something that doesn't occur anywhere in the file. Has to be a single character though...
unrootedtreefile <- as.matrix(read.table("old_genetrees.tre",sep="@",header=FALSE))

outputunrooted <- NULL

howmanytrees <- dim(unrootedtreefile)[1]
howmanytocull <- dim(tocull)[1]

j <- 1

while(j <=howmanytrees) {
for(i in 1:howmanytocull) {
temp <- paste(tocull[i,1],",",sep="")
cullline <- length(grep(temp,unrootedtreefile[j,1]))
if(cullline>0) {
break
}
}
if(cullline<1) {
outputunrooted <- cbind(outputunrooted,unrootedtreefile[j,1])
}
j <- j + 1
}

write.table(outputunrooted, "genetrees.tre", sep="",quote=FALSE, row.names=FALSE,col.names=FALSE)
```

This pipeline wouldn't be possible without:

R: R Core Team. 2015. R: A language and environment for statistical computing. URL http://www.R-project.org/. R Foundation for Statistical Computing, Vienna, Austria. https://www.r-project.org/
