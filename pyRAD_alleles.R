library(stringr)
intable <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
species <- read.table("species_assignments",header=FALSE,stringsAsFactors=FALSE,sep="")

rows <- dim(intable)[1]
individuals_no <- dim(species)[1]
uniquespecies <- unique(species[,2])
n_uniquespecies <- paste("n_",uniquespecies,sep="")
k_uniquespecies <- paste("k_",uniquespecies,sep="")
SNPs_uniquespecies <- paste("SNPs_",uniquespecies,sep="")
H_uniquespecies <-  paste("H_",uniquespecies,sep="")




locus_summary <- c("locus_ID","bp","n_total",n_uniquespecies, "k_total",k_uniquespecies,"SNPs_total",SNPs_uniquespecies,"H_total",H_uniquespecies,species[,1])

allele_file <- matrix(c(species[,1],species[,1]),ncol=1)
allele_file <- matrix(allele_file[order(allele_file[,1]),])
allele_file <- rbind("",allele_file)
SNP_file <- rbind("",allele_file)

species_file <- NULL
for (i in 1:(length(uniquespecies))) {
species_file[which(SNP_file


tempallelicstructure[(unique((which(proto_struct==ks[a,],arr.ind=TRUE))[,1])),1] <- a

<- uniquespecies[i]



locus_count <- 1
tempfile <- NULL

for (j in 1:rows) {
if ((length(grep("//",intable[j,1])))>0) {
tempfile <- tempfile[order(tempfile[,1]),]
seqlength <- nchar(tempfile[1,2])
tempseq <- unlist(strsplit(tempfile[(1:(dim(tempfile)[1])),2],""))
tempstructure <- t(matrix(tempseq,nrow=seqlength,ncol=(dim(tempfile)[1])))
no_indivs <- (dim(tempfile)[1])

As <- colSums(tempstructure=="A")
Cs <- colSums(tempstructure=="C")
Gs <- colSums(tempstructure=="G")
Ts <- colSums(tempstructure=="T")
Ms <- colSums(tempstructure=="M")
Rs <- colSums(tempstructure=="R")
Ws <- colSums(tempstructure=="W")
Ss <- colSums(tempstructure=="S")
Ys <- colSums(tempstructure=="Y")
Ks <- colSums(tempstructure=="K")
Ns <- colSums(tempstructure=="N") + colSums(tempstructure=="-")

ACMs <- which(((As > 0 & Cs > 0) | (As > 0 & Ms > 0) | (Cs > 0 & Ms > 0)) & Gs == 0 & Ts == 0 & Rs == 0 & Ws == 0 & Ss == 0 & Ys == 0 & Ks == 0 & Ns < no_indivs, arr.ind=TRUE)
AGRs <- which(((As > 0 & Gs > 0) | (As > 0 & Rs > 0) | (Gs > 0 & Rs > 0)) & Cs == 0 & Ts == 0 & Ms == 0 & Ws == 0 & Ss == 0 & Ys == 0 & Ks == 0 & Ns < no_indivs, arr.ind=TRUE)
ATWs <- which(((As > 0 & Ts > 0) | (As > 0 & Ws > 0) | (Ts > 0 & Ws > 0)) & Cs == 0 & Gs == 0 & Ms == 0 & Rs == 0 & Ss == 0 & Ys == 0 & Ks == 0 & Ns < no_indivs, arr.ind=TRUE)
CGSs <- which(((Cs > 0 & Gs > 0) | (Cs > 0 & Ss > 0) | (Gs > 0 & Ss > 0)) & As == 0 & Ts == 0 & Rs == 0 & Ws == 0 & Ms == 0 & Ys == 0 & Ks == 0 & Ns < no_indivs, arr.ind=TRUE)
CTYs <- which(((Cs > 0 & Ts > 0) | (Cs > 0 & Ys > 0) | (Ts > 0 & Ys > 0)) & As == 0 & Gs == 0 & Rs == 0 & Ws == 0 & Ms == 0 & Ss == 0 & Ks == 0 & Ns < no_indivs, arr.ind=TRUE)
GTKs <- which(((Gs > 0 & Ts > 0) | (Gs > 0 & Ks > 0) | (Ts > 0 & Ks > 0)) & As == 0 & Cs == 0 & Rs == 0 & Ws == 0 & Ms == 0 & Ss == 0 & Ys == 0 & Ns < no_indivs, arr.ind=TRUE)

sites <- array(c(ACMs,AGRs,ATWs,CGSs,CTYs,GTKs))
sites <- sites[order(sites)]
no_SNPs <- length(sites)

if (length(sites)==0) {
templocussummary <- c(locus_count,seqlength,no_indivs,n_uniquespecies, 1,k_uniquespecies,no_SNPs,SNPs_uniquespecies,0,H_uniquespecies,species[,1]
} else {
if(length(sites)==1) {
proto_struct <- cbind(tempfile[,1],(matrix(tempstructure[,sites])))
} else {
proto_struct <- cbind(tempfile[,1],tempstructure[,sites])
}
rm(tempfile)
rm(tempstructure)
proto_cols <- dim(proto_struct)[2]
no_k <- dim(unique(proto_struct[,2:proto_cols]))[1]
ks <- unique(proto_struct[,2:proto_cols])

tempallelicstructure <- matrix("",ncol=1,nrow=no_indivs)
for (a in 1:no_k) {
tempallelicstructure[(unique((which(proto_struct==ks[a,],arr.ind=TRUE))[,1])),1] <- a
}

tempSNPs <- matrix(0,ncol=no_SNPs,nrow=(individuals_no*2))
tempalleles <- matrix(0,ncol=1,nrow=(individuals_no*2))

i <- 1
while (i  <= no_indivs) {
for (k in 1:(individuals_no*2)) {
if ((length(grep(SNP_file[(k+2),1],proto_struct[i,1])))>0) {
tempSNPs[k,] <- proto_struct[i,2:(no_SNPs+1)]
tempSNPs[(k+1),] <- proto_struct[(i+1),2:(no_SNPs+1)]
tempalleles[k,] <- tempallelicstructure[i,]
tempalleles[(k+1),] <- tempallelicstructure[(i+1),]
break
}
}
i <- i+2
}



allele_file[i,1]


almost_struct <- cbind(almost_struct,proto_struct)
}

templocussummary <- c(locus_count,seqlength,no_indivs,n_uniquespecies, no_k,k_uniquespecies,"no_SNPs",SNPs_uniquespecies,"H_total",H_uniquespecies,species[,1]





tempfile <- NULL
locus_count <- locus_count + 1

} else {
tempname <- unlist(strsplit(intable[j,1],"[[:blank:]]+",fixed=FALSE))[1]
tempDNAseq <- unlist(strsplit(intable[j,1],"[[:blank:]]+",fixed=FALSE))[2]
tempcombine <- cbind(tempname,tempDNAseq)
tempfile <- rbind(tempfile,tempcombine)
}
}
