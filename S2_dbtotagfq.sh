#!/bin/bash -l
#SBATCH -J S2_dbtotagfq
#SBATCH -o S2_dbtotagfq.out
#SBATCH --mail-user=mshu@ucmerced.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mem=4000
#SBATCH -p std.q
#SBATCH -t 24:00:00

/home/mshu/TASSEL_5/run_pipeline.pl -Xms100G -Xmx300G -fork1 -TagExportToFastqPlugin -db /home/mshu/GBS_96/S2_dbtotagfq/input/GBS_S1.db -o /home/mshu/GBS_96/S2_dbtotagfq/output/GBS_S2_tag.fa.gz -c 1 -endPlugin -runfork1