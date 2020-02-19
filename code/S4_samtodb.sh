#!/bin/bash -l
#SBATCH -J S4_samtodb
#SBATCH -o S4_samtodb.out
#SBATCH --mail-user=mshu@ucmerced.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mem=4000
#SBATCH -p std.q
#SBATCH -t 24:00:00

/home/mshu/TASSEL_5/run_pipeline.pl -Xms100G -Xmx300G -fork1 -SAMToGBSdbPlugin -i /home/mshu/GBS_96/S4_samtodb/input/GBS_96_bowtie2.sam -db /home/mshu/GBS_96/S4_samtodb/input/GBS_S1.db -aProp 0.0 -aLen 0 -endPlugin -runfork1
