#!/bin/bash -l
#SBATCH -J S6_prodSNP_vcf
#SBATCH -o S6_prodSNP_vcf.out
#SBATCH --mail-user=mshu@ucmerced.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mem=4000
#SBATCH -p std.q
#SBATCH -t 24:00:00

/home/mshu/TASSEL_5/run_pipeline.pl -fork1 -Xms100G -Xmx200G -ProductionSNPCallerPluginV2 -db /home/mshu/GBS_96/S6_prodSNP_vcf/input/GBS_S5.db -e ApeKI -i /home/mshu/GBS_96/Data -k /home/mshu/GBS_96/Data/GBS_96_key.txt -kmerLength 64 -o /home/mshu/GBS_96/S6_prodSNP_vcf/output/GBS_96.vcf -mnQS 20 -endPlugin -runfork1