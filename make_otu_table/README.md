# make_otu_table
Originally at: https://github.com/laninsky/make_otu_table

Converting from obitools/sumaclust fasta file to an OTU table

Expects a fasta file formatted as follows:
```
>M01168:336:000000000-BP8T5:1:1102:18849:4209_CONS_SUB_SUB_CMP count=10; merged_sample={'GGW2_18S1': 2, 'GW1_18S1': 1, 'GW3_18S1': 7}; cluster_weight=10; cluster=M01168:336:000000000-BP8T5:1:1102:18849:4209_CONS_SUB_SUB_CMP; cluster_score=1.000000; cluster_center=True; 
cgcccgtcggtatttccgattgaatggcttagtgagaacttcggattgaggggatgtgct
taacggcgtgtcttcacgagaagttggtcaaacttggtcatttagaggaagtaaaagtcg
taacaaggtttcc
>M01168:336:000000000-BP8T5:1:1101:22036:3363_CONS_SUB_SUB_CMP count=10; merged_sample={'Dores3_18S1': 1, 'GW1_18S1': 1, 'GW3_18S1': 3, 'Dores2_18S1': 3, 'LE1_18S1': 1, 'Dores1_18S1': 1}; cluster_weight=6266; cluster=M01168:336:000000000-BP8T5:1:1103:21600:7128_CONS_SUB_SUB; cluster_score=0.992424; cluster_center=False; 
cgcccgttgcttcaatcgactgagtgttccggtgaatgattcggattgacgattttcgtg
gaaacacgtgattgttgagaagttttgtaaaccaaaacacttgaagaatgaaaaaatcgt
agcacggtatct
>M01168:336:000000000-BP8T5:1:1103:21600:7128_CONS_SUB_SUB count=10; merged_sample={'Dores2_18S1': 10}; cluster_weight=10; cluster=M01168:336:000000000-BP8T5:1:1103:21600:7128_CONS_SUB_SUB; cluster_score=1.000000; cluster_center=True; 
cgcccgtcggtatttccgattgaatggtttagtgaggcctttggattagcgtgccctttt
gggtgtgccgagaaattggacaaacttgatcatttagaggaagtaaaagtcgtaacaagg
tttcc
```
The read name is located next to the start-of-line carrot. The sample locations and number of reads are located within merged_sample={}, and the OTU the read is assigned to follows cluster=. Each OTU may contain multiple reads. In this example, the 2nd and 3rd reads are assigned to the same OTU.

To use the code, paste the R-code from this repository into your R console and then execute it by:
```
make_otu_table(fasta_file)
```
where fasta_file = the path to where your fasta_file is located e.g.
```
make_otu_table("/Users/alanaalexander/Downloads/test_fasta.fasta")
```
This will return a file called otu_table.csv into your working directory. For the example three-line fasta above, this would be:
```
,GGW2_18S1,GW1_18S1,GW3_18S1,Dores3_18S1,Dores2_18S1,LE1_18S1,Dores1_18S1
M01168:336:000000000-BP8T5:1:1102:18849:4209_CONS_SUB_SUB_CMP,2,1,7,0,0,0,0
M01168:336:000000000-BP8T5:1:1103:21600:7128_CONS_SUB_SUB,0,1,3,1,13,1,1
```
OTU name is located in the left-most column, followed by columns of sample locations and the number of reads assigned to each OTU.

## Version history 
Wrote this as a one-off goof to help out a lab mate. I am no longer actively maintaining this repository, but will respond to issues.
