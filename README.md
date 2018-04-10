As input, this script expects a file formatted like the following:
```
>bcc_99995|Cycle_0|Type_0a|upper_path_length_83|C1_0|C2_0|C3_0|C4_0|C5_0|C6_1|C7_0|C8_0|C9_0|C10_0|C11_0|C12_0|C13_0|C14_0|C15_0|C16_0|C17_0|C18_0|C19_0|C20_0|C21_1|C22_1|C23_0|C24_0|C25_0|C26_0|C27_0|C28_0|Q1_0|Q2_0|Q3_0|Q4_0|Q5_0|Q6_70|Q7_0|Q8_0|Q9_0|Q10_0|Q11_0|Q12_0|Q13_0|Q14_0|Q15_0|Q16_0|Q17_0|Q18_0|Q19_0|Q20_0|Q21_70|Q22_70|Q23_0|Q24_0|Q25_0|Q26_0|Q27_0|Q28_0|rank_1.00000
GTTCTTTAACCCTGCACACAAAGAAAACTATCATTCAATCAGAGCCATCATCTCAGAGCTGCTGCTTTTTTTTCTCCAGAGCA
>bcc_99995|Cycle_0|Type_0a|lower_path_length_83|C1_3|C2_3|C3_0|C4_0|C5_0|C6_0|C7_0|C8_0|C9_0|C10_0|C11_0|C12_0|C13_0|C14_0|C15_3|C16_3|C17_0|C18_0|C19_0|C20_0|C21_0|C22_0|C23_0|C24_0|C25_0|C26_0|C27_0|C28_0|Q1_70|Q2_70|Q3_0|Q4_0|Q5_0|Q6_0|Q7_0|Q8_0|Q9_0|Q10_0|Q11_0|Q12_0|Q13_0|Q14_0|Q15_70|Q16_70|Q17_0|Q18_0|Q19_0|Q20_0|Q21_0|Q22_0|Q23_0|Q24_0|Q25_0|Q26_0|Q27_0|Q28_0|rank_1.00000
GTTCTTTAACCCTGCACACAAAGAAAACTATCATTCAATCAAAGCCATCATCTCAGAGCTGCTGCTTTTTTTTCTCCAGAGCA
```
Each SNP has two lines (one for each allelic state). Samples are designated by "C[0-9]", and separated from the per-sample read count by an underscore. Each sample is separated from the following samples by a "|"

This script will filter for SNPs where at least one individual has at least 10 reads for at least one allele.
