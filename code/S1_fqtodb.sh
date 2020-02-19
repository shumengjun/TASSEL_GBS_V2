#!/bin/bash -l
#SBATCH -J S1_fqtodb
#SBATCH -o S1_fqtodb.out
#SBATCH --mail-user=mshu@ucmerced.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mem=4000
#SBATCH -p std.q
#SBATCH -t 24:00:00


/home/mshu/TASSEL_5/run_pipeline.pl -Xms100G -Xmx300G -fork1 -GBSSeqToTagDBPlugin -e ApeKI -i /home/mshu/GBS_96/Data -db /home/mshu/GBS_96/S1_fqtodb/output/GBS_S1.db -k /home/mshu/GBS_96/Data/GBS_96_key.txt -c 5 -kmerLength 64 -minKmerL 20 -mnQS 20 -endPlugin -runfork1
