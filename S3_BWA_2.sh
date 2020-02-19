#!/bin/bash -l
#SBATCH -J S3_BWA_2
#SBATCH -o S3_BWA_2.out
#SBATCH --mail-user=mshu@ucmerced.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mem=4000
#SBATCH -p std.q
#SBATCH -t 24:00:00

/home/mshu/bwa-0.7.17/bwa aln -t 4 /home/mshu/GBS_96/S3_BWA/Pita_chr12.fasta /home/mshu/GBS_96/S3_BWA/input/GBS_S2_tag.fa.gz > /home/mshu/GBS_96/S3_BWA/output/GBS_S2_tag.sai