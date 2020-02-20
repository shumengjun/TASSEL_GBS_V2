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
## Output File
[VCF file](https://datadryad.org/stash/dataset/doi:10.5061/dryad.6fv8fb4)
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
## Step 2: db to tag fq file
- Code: S2_dbtotagfq.sh
- Input: .db file
- Plugin: -TagExportToFastqPlugin
- Minimum count reads: 1
- Output: .fa.gz file 
## Step 3_bwa_1:
- Code: S3_BWA_1.sh
- Input: reference fasta file
- Output: five files
## Step 3_bwa_2:
- Code: S3_BWA_2.sh
- Input: .fa.gz file and the five files from Step 3_bwa_1
- Output: .sai file
## Step 3_bwa_3:
- Code: S3_BWA_3.sh
- Input: .fa.gz file, the five files from Step 3_bwa_1, and the .sai file
- Output: .sam file
## Step 3_bowtie2_1:
- Code: S3_bowtie2_1.sh
- Input: reference fasta file
- Output: five files and .fa.gz file
## Step 3_bowtie2_2:
- Code: S3_bowtie2_2.sh
- Input: five files and .fa.gz file from step 3_bowtie2_1
- Output: .sam file
## Step 4_samtodb:
- Code: S4_samtodb.sh
- Input: .sam file from step bowtie2_2, .db file from step 2
- Plugin: -SAMToGBSdbPlugin
- Output: updated .db file
## Step 5_discSNP:
- Code: S5_discSNP.sh
- Input: updated .db file from Step 4
- Plugin: -DiscoverySNPCallerPluginV2
- -mnLCov <Min Locus Coverage>: 0.1
- Output: updated .db file
## Step 6_prodSNP_vcf:
- Code: S6_prodSNP_vcf.sh
- Input: raw fasta file, barcode file, updated .db file from Step 5
- Kmer length: 64
- Plugin: -ProductionSNPCallerPluginV2
- mnQS: 20
- Output: .vcf file
## Step 6_prodSNP_h5:
- Code: S6_prodSNP_h5.sh
- Input:raw fasta file, barcode file, updated .db file from Step 5
- Kmer length: 64
- Plugin: -ProductionSNPCallerPluginV2
- mnQS: 20
- Output: .h5 file
