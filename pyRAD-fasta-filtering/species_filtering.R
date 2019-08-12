library(stringr)
intable <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
species <- read.table("species_assignments",header=FALSE,stringsAsFactors=FALSE,sep="\t")
locusname <- read.table("tempname",header=FALSE,stringsAsFactors=FALSE,sep="\t")

rows <- dim(intable)[1]
species_no <- dim(species)[1]

i <- 1
while (i < rows) {
if ((length(grep(">",intable[i,1])))>0) {
seqlength <- nchar(gsub("N","",intable[(i+1),1]))
if (seqlength > 0) {
output <- rbind(intable[i,1],intable[(i+1),1])
name <- (gsub(">","",intable[i,1]))
for (j in 1:species_no) {
if(name==species[j,1]) {
outputname<-paste(species[j,2],"/",locusname[1,1],sep="")
write.table(output, outputname,quote=FALSE, col.names=FALSE,row.names=FALSE)
break
}
}
}
i <- i + 2
}
}
