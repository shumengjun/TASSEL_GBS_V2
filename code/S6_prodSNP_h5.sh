#!/bin/bash -l
#SBATCH -J S6_prodSNP_h5
#SBATCH -o S6_prodSNP_h5.out
#SBATCH --mail-user=mshu@ucmerced.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mem=200GB
#SBATCH -p fast.q
#SBATCH -t 4:00:00

/home/mshu/TASSEL_5/run_pipeline.pl -fork1 -Xms100G -Xmx250G -ProductionSNPCallerPluginV2 -db /qsb/mshu/GBS_96/S6_prodSNP_h5/input/GBS_S5.db -e ApeKI -i /qsb/mshu/GBS_96/Data -k /qsb/mshu/GBS_96/Data/GBS_96_key.txt -kmerLength 64 -o /qsb/mshu/GBS_96/S6_prodSNP_h5/output/GBS_96.h5 -mnQS 20 -endPlugin -runfork1
