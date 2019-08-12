intable <- read.table("het_count.txt",header=TRUE,stringsAsFactors=FALSE)

rows <- dim(intable)[1]

maxhets <- max(intable[1:rows,2])

output <- NULL

for (i in 0:maxhets) {
no_loci <- sum(intable[,2]==i)
no_sites <- sum(intable[(intable[,2]==i),3])
no_polysites <- no_loci * i
tempoutput <- c(i, no_loci, no_sites, no_polysites)
output <- rbind(output,tempoutput)
}

total_loci <- paste("Total number of loci =",sum(output[,2]))
total_sites <-  paste("Total number of sites across all loci =",sum(output[,3]))
pi <- paste("Total observed nucleotide diversity =",sum(output[,4])/sum(output[,3]))
heterozygosity <- paste("Total observed heterozygosity at the per locus level =",(1 - ((sum(output[(output[,1]==0),2]))/(sum(output[,2])))))

colnames(output) <- c("number_of_het_sites_per_locus","number_of_loci","total_number_of_sites", "total_number_of_het_sites")

print(noquote(total_loci))
print(noquote(total_sites))
print(noquote(pi))
print(noquote(heterozygosity))
flush.console()

output1 <- matrix("",nrow=4,ncol=4)
output1[,1] <- c(total_loci,total_sites,pi,heterozygosity)

output <- rbind(output,output1)

write.table(output, "summarize_het.txt", sep="\t",quote=FALSE, row.names=FALSE,col.names=TRUE)

