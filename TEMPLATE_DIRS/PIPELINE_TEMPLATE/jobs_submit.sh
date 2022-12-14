#!/bin/bash

echo sbatch --job-name=cv_alg-${1}_outcome-ar_stdprice_total_res-${2}_hdim-0 --export=alg=${1},resolution=${2},hdim=0 --mail-user=fpichard@umn.edu -p small submit_scripts/cv_outcome-ar_stdprice_total.sbatch
echo sbatch --job-name=cv_alg-${1}_outcome-ar_stdprice_total_res-${2}_hdim-1 --export=alg=${1},resolution=${2},hdim=1 --mail-user=fpichard@umn.edu -p small submit_scripts/cv_outcome-ar_stdprice_total.sbatch
