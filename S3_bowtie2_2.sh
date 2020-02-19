#!/bin/bash -l
#SBATCH -J S3_bowtie2_2
#SBATCH -o S3_bowtie2_2.out
#SBATCH --mail-user=mshu@ucmerced.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mem=4000
#SBATCH -p std.q
#SBATCH -t 24:00:00

/opt/bowtie2/bowtie2-2.2.9/bowtie2 -p 15 --very-sensitive -x /home/mshu/GBS_96/S3_bowtie2/Pita_chr12 -U /home/mshu/GBS_96/S3_bowtie2/input/GBS_S2_tag.fa.gz -S /home/mshu/GBS_96/S3_bowtie2/output/GBS_96_bowtie2.sam