#!/bin/bash -l
#SBATCH -J S3_bowtie2_1
#SBATCH -o S3_bowtie2_1.out
#SBATCH --mail-user=mshu@ucmerced.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mem=4000
#SBATCH -p std.q
#SBATCH -t 24:00:00

/opt/bowtie2/bowtie2-2.2.9/bowtie2-build /home/mshu/GBS_96/Refgenome/Pita_chr12.fasta /home/mshu/GBS_96/S3_bowtie2/Pita_chr12