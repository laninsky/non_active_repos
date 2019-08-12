library(stringr)
intable <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
locusname <- read.table("tempname",header=FALSE,stringsAsFactors=FALSE,sep="\t")

seqlength <- nchar(intable[2,1])

Mcount <- seqlength - nchar(gsub("M","",intable[2,1]))
Rcount <- seqlength - nchar(gsub("R","",intable[2,1]))
Wcount <- seqlength - nchar(gsub("W","",intable[2,1]))
Scount <- seqlength - nchar(gsub("S","",intable[2,1]))
Ycount <- seqlength - nchar(gsub("Y","",intable[2,1]))
Kcount <- seqlength - nchar(gsub("K","",intable[2,1]))

ambigs <- Mcount + Rcount + Wcount + Scount + Ycount + Kcount

output <- paste(locusname[1,1],ambigs,seqlength)

write.table(output, "het_count.txt",quote=FALSE, col.names=FALSE,row.names=FALSE,append=TRUE)
