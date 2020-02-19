#!/bin/bash -l
#SBATCH -J S3_BWA_1
#SBATCH -o S3_BWA_1.out
#SBATCH --mail-user=mshu@ucmerced.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mem=4000
#SBATCH -p std.q
#SBATCH -t 24:00:00

/home/mshu/bwa-0.7.17/bwa index -a bwtsw /home/mshu/GBS_96/Refgenome/Pita_chr12.fasta
