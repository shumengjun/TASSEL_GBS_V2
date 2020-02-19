#!/bin/bash -l
#SBATCH -J S5_discSNP
#SBATCH -o S5_discSNP.out
#SBATCH --mail-user=mshu@ucmerced.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mem=4000
#SBATCH -p long.q
#SBATCH -t 336:00:00

/home/mshu/TASSEL_5/run_pipeline.pl -fork1 -Xms100G -Xmx200G -DiscoverySNPCallerPluginV2 -db /home/mshu/GBS_96/S5_discSNP/input/GBS_S4.db -sC 1 -eC 12 -mnLCov 0.1 -mnMAF 0.01 -deleteOldData true -endPlugin -runfork1
