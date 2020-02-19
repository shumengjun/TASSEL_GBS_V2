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



Laptop:
/Desktop/GBS/GBS_96
•	Code
o	S1_fqtodb.sh
o	S2_dbtotagfq.sh
o	S3_bowtie2_1.sh
o	S3_bowtie2_2.sh
o	3_BWA_1.sh
o	3_BWA_2.sh
o	3_BWA_3.sh
o	S4_samtodb.sh
o	S5_discSNP.sh
o	S6_prodSNP_h5.sh
o	S6_prodSNP_vcf.sh
•	Data
o	GBS_96_key.txt
o	GBS_96_ReadsPerSample.txt
•	GBS_96_steps.docx

Merced cluster:
/home/mshu/GBS_96
•	Data
o	HG2C5BBXX_5_fastq.gz, 21 GB
o	HGGWTBBXX_6_fastq.gz, 19 GB
o	GBS_96_key.txt
•	Refgenome
o	Pita.fasta, 22 GB, https://treegenesdb.org/FTP/Genomes/Pita/ 
o	Pita_chr12.fasta, 22 GB
•	Code
o	S1_fqtodb.sh
o	S1_fqtodb.out
o	S2_dbtotagfq.sh
o	S2_dbtotagfq.out
o	S3_BWA_1.sh
o	S3_BWA_1.out
o	S3_BWA_2.sh
o	S3_BWA_2.out
o	S3_BWA_3.sh
o	S3_BWA_3.out
o	S3_bowtie2_1.sh
o	S3_bowtie2_1.out
o	S3_bowtie2_2.sh
o	S3_bowtie2_2.out
o	S4_samtodb.sh
o	S4_samtodb.out
o	S5_discSNP.sh
o	S5_discSNP.out
o	S6_prodSNP_h5.sh
o	S6_prodSNP_h5.out
o	S6_prodSNP_vcf.sh
o	S6_prodSNP_vcf.out
•	S1_fqtodb
o	output
	GBS_S1.db, 937 MB
•	S2_dbtotagfq
o	Input
	GBS_S1.db, 937 MB
o	Output
	GBS_S2_tag.fa.gz, 181 MB
•	S3_BWA
o	Input
	GBS_S2_tag.fa.gz, 181 MB
o	Output
	GBS_96_BWA.sam, 1993 MB
	GBS_S2_tag.sai, 847 MB
o	Pita_chr12.fasta.amb
o	Pita_chr12.fasta.ann
o	Pita_chr12.fasta.bwt
o	Pita_chr12.fasta.pac
o	Pita_chr12.fasta.sa
•	S3_bowtie2
o	Input:
	GBS_S2_tag.fa.gz, 181 MB
o	Output:
	GBS_96_bowtie2.sam, 2063 MB
o	Pita_chr12.1.bt2l
o	Pita_chr12.2.bt2l
o	Pita_chr12.3.bt2l
o	Pita_chr12.4.bt2l
o	Pita_chr12.rev.1.bt2l
o	Pita_chr12.rev.2.bt2l
•	S4_samtodb
o	Input
	GBS_96_bowtie2.sam, 2063 MB
o	Output
	GBS_S4.db, 1285 MB
•	S5_discSNP
o	Input
o	Output
	GBS_S5.db, 4826 MB
•	S6_prodSNP_h5
o	Input
	GBS_S4.db, 1285 MB
o	Output
	GBS_96.h5, 471 MB
	GBS_96_ReadsPerSample.log
•	S6_prodSNP_vcf
o	Input
	GBS_S4.db, 1285 MB
o	Output
	GBS_96.vcf, 7216 MB
	GBS_96_ReadsPerSample.log
	GBS_96_ReadsPerSample.txt

Code for changing Pita.fasta to Pita_chr12.fasta:
Step1: Add chr
•	Code:
o	sed -i -e 's/^>/>chr/XXX.fasta
•	Referenced website:
o	http://okko73313.blogspot.com/2013/01/chromosome-names-with-chr-prefix-or.html 
Step2: Change name to number 
•	Code:
o	awk '/^>/{print ">" ++i; next}{print}' < XXX.fasta > newXXX.fasta
•	Referenced website:
o	https://www.biostars.org/p/53212/
Step3: Count the number of sequences in fasta file (1762655)
•	Code:
o	grep -c "^>" newXXX.fasta
•	referenced website:
o	https://www.biostars.org/p/17680/
Step4: Unique number of sequence name in fasta file
•	Code: 
o	grep -o '>\S*' Pita_new.fasta | sort | uniq | wc -l
•	Referenced website：
o	http://gtamazian.blogspot.com/2013/08/how-to-determine-if-there-are-duplicate.html
Step5: Change the name of fasta file into numbers from 1 to 12
•	Code:
o	awk '$1 <= 12240 {print">"1; next}{print}'< XXX.fasta > 1.fasta 
o	awk '$1 <= 24480 {print">"2; next}{print}'< 1.fasta > 2.fasta 
o	awk '$1 <= 36720 {print">"3; next}{print}'< 2.fasta > 3.fasta 
o	awk '$1 <= 48960 {print">"4; next}{print}'< 3.fasta > 4.fasta 
o	awk '$1 <= 61200 {print">"5; next}{print}'< 4.fasta > 5.fasta 
o	awk '$1 <= 73440 {print">"6; next}{print}'< 5.fasta > 6.fasta 
o	awk '$1 <= 85680 {print">"7; next}{print}'< 6.fasta > 7.fasta 
o	awk '$1 <= 97920 {print">"8; next}{print}'< 7.fasta > 8.fasta 
o	awk '$1 <= 110160 {print">"9; next}{print}'< 8.fasta > 9.fasta 
o	awk '$1 <= 122400 {print">"10; next}{print}'< 9.fasta > 10.fasta 
o	awk '$1 <= 134640 {print">"11; next}{print}'< 10.fasta > 11.fasta 
o	awk '$1 <= 146888 {print">"12; next}{print}'< 11.fasta > 12.fasta 
o	awk '$1 <= 293776 {print">"2; next}{print}'< 12.fasta > 13.fasta 
o	awk '$1 <= 440664 {print">"3; next}{print}'< 13.fasta > 14.fasta 
o	awk '$1 <= 587552 {print">"4; next}{print}'< 14.fasta > 15.fasta 
o	awk '$1 <= 734440 {print">"5; next}{print}'< 15.fasta > 16.fasta 
o	awk '$1 <= 881328 {print">"6; next}{print}'< 16.fasta > 17.fasta 
o	awk '$1 <= 1028216 {print">"7; next}{print}'< 17.fasta > 18.fasta 
o	awk '$1 <= 1175104 {print">"8; next}{print}'< 18.fasta > 19.fasta 
o	awk '$1 <= 1321992 {print">"9; next}{print}'< 19.fasta > 20.fasta 
o	awk '$1 <= 1468880 {print">"10; next}{print}'< 20.fasta > 21.fasta
o	awk '$1 <= 1615768 {print">"11; next}{print}'< 21.fasta > 22.fasta 
o	awk '$1 <= 1628008 {print">"1; next}{print}'< 22.fasta > 23.fasta 
o	awk '$1 <= 1640248 {print">"2; next}{print}'< 23.fasta > 24.fasta 
o	awk '$1 <= 1652488 {print">"3; next}{print}'< 24.fasta > 25.fasta 
o	awk '$1 <= 1664728 {print">"4; next}{print}'< 25.fasta > 26.fasta 
o	awk '$1 <= 1676968 {print">"5; next}{print}'< 26.fasta > 27.fasta 
o	awk '$1 <= 1689208 {print">"6; next}{print}'< 27.fasta > 28.fasta 
o	awk '$1 <= 1701448 {print">"7; next}{print}'< 28.fasta > 29.fasta
o	awk '$1 <= 1713688 {print">"8; next}{print}'< 29.fasta > 30.fasta 
o	awk '$1 <= 1725928 {print">"9; next}{print}'< 30.fasta > 31.fasta 
o	awk '$1 <= 1738168 {print">"10; next}{print}'< 31.fasta > 32.fasta
o	awk '$1 <= 1750408 {print">"11; next}{print}'< 32.fasta > 33.fasta 
o	awk '$1 <= 1762655 {print">"12; next}{print}'< 33.fasta > 34.fasta 

Code for GBS V2 pipeline
Step 1: fastq to db file
Code:
•	S1_fqtodb.sh
Input:
•	Two files in folder /home/mshu/GBS_96/Data
•	Plugin: -GBSSeqToTagDBPlugin
•	Restriction enzyme: ApeKI
•	Key file GBS_96_key.txt in folder /home/mshu/GBS_96/Data
•	Minimum Kmer length: 20
•	Maximum Kmer length: 64
•	Minimum Kmer count: 5
•	Minimum count reads: 1
Output:
•	/home/mshu/GBS_96/S1_fqtodb/output/GBS_S1.db
•	S1_fqtodb.out
Duration:
•	52 minutes
•	Merced cluster standard queue
Note:
•	S1_fqtodb.out file contains the information about number of reads in lane, number of good barcoded reads, number of low quality reads, number of tags, average read depth.

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
