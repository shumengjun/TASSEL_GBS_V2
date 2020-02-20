# TASSEL_GBS_V2
Using TASSEL GBS V2 pipeline to call SNPs with GBS raw data of **94 ponderosa pine** (*Pinus ponderosa*) and the reference genome of **loblolly pine** (*Pinus taeda*).

## Software
- Version: TASSEL Version 5.0, GBS V2
- Website: http://www.maizegenetics.net/tassel 
- Manual: https://bitbucket.org/tasseladmin/tassel-5-source/wiki/Tassel5GBSv2Pipeline 
## Input File
- [Raw fasta file](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA527618&o=acc_s%3Aa) produced by GBS (Genotyping by sequencing) with restriction enzyme *Ape*KI
- Reference genome of [**loblolly pine** (*Pinus taeda*)](https://treegenesdb.org/FTP/Genomes/Pita/)
- Barcode information 
## Step 1: fastq to db file
- Code: S1_fqtodb.sh
- Input: Two fasta file & one barcode file
- Plugin: -GBSSeqToTagDBPlugin
- Restriction enzyme: ApeKI
- Minimum Kmer length: 20
-	Maximum Kmer length: 64
- Minimum Kmer count: 5
- Minimum count reads: 1
- Output: A .db file


Step 2: db to tag fq file
Code:
•	S2_dbtotagfq.sh
Input:
•	/home/mshu/GBS_96/S2_tagfromdb/input/GBS_S1.db
•	Plugin: -TagExportToFastqPlugin
•	Minimum count reads: 1
Output:
•	/home/mshu/GBS_96/S2_dbtotagfq/output/GBS_S2_tag.fa.gz
•	S2_dbtotagfq.out
Duration:
•	
•	Merced cluster standard queue
Note:
•	S2_dbtotagfq.out file contains the information about total number of tags written (7462645)

Step 3_bwa_1:
Code:
•	S3_BWA_1.sh
Input:
•	/home/mshu/GBS_96/Refgenome/Pita_chr12.fasta
Output:
•	Five files in folder /home/mshu/GBS_96/S3_BWA
•	S3_BWA_1.out
Duration:
•	16.5 hours
•	Merced cluster standard queue
Note:

Step 3_bwa_2:
Code:
•	S3_BWA_2.sh
Input:
•	/home/mshu/GBS_96/S3_BWA/input/GBS_S2_tag.fa.gz
•	Five files in folder /home/mshu/GBS_96/S3_BWA
Output:
•	S3_BWA_2.out
•	/home/mshu/GBS_96/S3_BWA/output/GBS_S2_tag.sai
Duration:
•	30 minutes
•	Merced cluster standard queue
Note:
•	Using output file of step 2 GBS_S2_tag.fa.gz as the input file

Step 3_bwa_3:
Code:
•	S3_BWA_3.sh
Input:
•	/home/mshu/GBS_96/S3_BWA/input/GBS_S2_tag.fa.gz
•	/home/mshu/GBS_96/S3_BWA/output/GBS_S2_tag.sai
•	Five files in folder /home/mshu/GBS_96/S3_BWA
Output:
•	S3_BWA_3.out
•	/home/mshu/GBS_96/S3_BWA/output/GBS_96_BWA.sam
Duration:
•	30 minutes
•	Merced cluster standard queue
Note:
•	In the S3_BWA_3.out, there is no information about the percentage of alignment.

Step 3_bowtie2_1:
Code:
•	S3_bowtie2_1.sh
Input:
•	/home/mshu/GBS_96/Refgenome/Pita_chr12.fasta
Output:
•	Five files in folder /home/mshu/GBS_96/S3_bowtie2
•	S3_bowtie2_1.out
Duration:
•	16.5 hours
•	Merced cluster standard queue
Note:

Step 3_bowtie2_2:
Code:
•	S3_bowtie2_2.sh
Input:
•	/home/mshu/GBS_96/S3_bowtie2/input/GBS_S2_tag.fa.gz
•	Five files in folder /home/mshu/GBS_96/S3_bowtie2
Output:
•	/home/mshu/GBS_96/S3_bowtie2/output/GBS_96_bowtie2.sam
•	S3_bowtie2_2.out
Duration:
•	7 minutes
•	Merced cluster standard queue
Note:
•	Using output file of step 2 GBS_S2_tag.fa.gz as the input file 
•	The S3_bowtie2_2.out file contains the information about number of reads being aligned o time, exactly 1 time and more than 1 times

Step 4_samtodb:
Code:
•	S4_samtodb.sh
Input:
•	/home/mshu/GBS_96/S4_samtodb/input/GBS_96_bowtie2.sam
•	/home/mshu/GBS_96/S4_samtodb/input/GBS_S1.db
•	Plugin: -SAMToGBSdbPlugin
Output:
•	/home/mshu/GBS_96/S4_samtodb/output/GBS_S4.db, 1285 mb
•	S4_samtodb.out
Duration:
•	9 minutes
•	Merced cluster standard queue
Note:
•	sam input file is the output file of S3_bowtie2_2
•	db input file is the output file of S1_fqtodb
•	The output file GBS_S4.db is larger than the input db file
•	The S4_samtodb.out file contains the information about number of cut sites with different tags, total number of tags mapped and not mapped
•	Output db file changed directly from the input db file, rename the db file and then move it to the folder /home/mshu/GBS_96/S4_samtodb/output


Step 5_discSNP:
Code:
•	S5_discSNP.sh
Input:
•	/home/mshu/GBS_96/S4_samtodb/input/GBS_S1.db
•	Plugin: -DiscoverySNPCallerPluginV2
•	-mnLCov <Min Locus Coverage>: 0.1
Output:
•	GBS_S5.db, 4826 MB
•	S5_discSNP.out
Duration:
•	2.5 hours
•	Merced cluster long queue
Note:
•	Output db file changed directly from the input db file, rename the db file and then move it to the folder /home/mshu/GBS_96/S5_discSNP/output/GBS_S5.db
•	 Minimum locus coverage means proportion of Taxa with a genotype

Step 6_prodSNP_vcf:
Code:
•	S6_prodSNP_vcf.sh
Input:
•	Two files in folder /home/mshu/GBS_96/Data
•	Restriction enzyme: ApeKI
•	Key file in folder /home/mshu/GBS_96/Data
•	Kmer length: 64
•	/home/mshu/GBS_96/S6_prodSNP_vcf/input/GBS_S5.db
•	Plugin: -ProductionSNPCallerPluginV2
•	mnQS: 20
Output:
•	/home/mshu/GBS_96/S6_prodSNP_vcf/output/GBS_96.vcf
•	S6_prodSNP_vcf.out
•	GBS_96_ReadsPerSample.log
•	
Duration:
•	1 hour
•	Merced cluster standard queue
Note:
•	Using the output file GBS_S5.db of S5_discSNP as the input file
•	The S6_prodSNP_vcf.out file contains the information about number of SNPs
•	GBS_96_ReadsPerSample.log file contains the information about number of good barcoded reads and good reads matched to data base of each sample
•	Using code cat GBS_96_ReadsPerSample.log >> GBS_96_ReadsPerSample.txt to write the GBS_96_ReadsPerSample.log file into a txt file

Step 6_prodSNP_h5:
Code:
•	S6_prodSNP_h5.sh
Input:
•	Two files in folder /home/mshu/GBS_96/Data
•	Restriction enzyme: ApeKI
•	Key file in folder /home/mshu/GBS_96/Data
•	Kmer length: 64
•	/home/mshu/GBS_96/S6_prodSNP_h5/input/GBS_S5.db
•	Plugin: -ProductionSNPCallerPluginV2
•	mnQS: 20
Output:
•	/home/mshu/GBS_96/S6_prodSNP_h5/output/GBS_96.h5
•	S6_prodSNP_h5.out
Duration:
•	1 hour
•	Merced cluster fast queue
Note:
•	Using the output file GBS_S5.db of S5_discSNP as the input file
•	The S6_prodSNP_h5.out file contains the information about number of SNPs 
•	GBS_96_ReadsPerSample.log file contains the information about number of good barcoded reads and good reads matched to data base of each sample
•	Using code cat GBS_96_ReadsPerSample.log >> GBS_96_ReadsPerSample.txt to write the GBS_96_ReadsPerSample.log file into a txt file
