#!/bin/bash -l
#SBATCH --time=24:00:00
#SBATCH --ntasks=8
#SBATCH --mem=10g
#SBATCH --tmp=10g
#SBATCH --mail-type=ALL
#SBATCH --output=../log_files/SB-%x-%a.%A.out
#SBATCH --error=../log_files/SB-%x-%a.%A.err
####
#
#Pass a path to a file for a script you are running.
#Use --export=input_file=PATH_TO_FILE,OTHER_VAR=VALUE
#Use --job-name=NAME to distinguish the sbatch job in the queue.
#Use --mail-user=EMAIL@EMAIL.EDU
#Use --aray=x-y to run sub file ${input_file}_x to sub file ${input_file}_y
#Use --array=x,y,z to run only files ${input_file}_x, ${input_file}_y, ${input_file}_z
#Use -p small to submit to small queue
#Use ""sbatch {Options} -p small SCRIPT.sbtach" to submit job.
#
#Created: FMP
#Last updated: 17032021 - FMP
####

##Move to pipeline dir
cd ${SLURM_SUBMIT_DIR}


###LOAD NECESSARY MODULES!
## Needs to go before loading defaults for globus dirs to work
#module load fsl/6.0.1
#module load python3
#module load camino
#module load freesurfer/6.0.0
#module load globus-cli
#module load afni/19.3.14
#module load ants
#module load c3d


##Load Default Variables/directories
load_defaults="../General_Scripts/load_defaults.sh"
set -a
source ${load_defaults}
set +a


##Create work_dir if it doesn't exist
# Some cohorts have no session number
# If ses_num is empty, that part of the variable name will be empty
if [ ${ses} ]; then
  ses_str="_${ses}"     # ses for variable names (needs _)
else
  ses="NA"              # needed for HCP and other non-ses cohorts
  ses_str=""
fi

ppl_name=$(basename $(pwd))
ppl_work_dir="../work_dir/${ppl_name}_${cohort_name}${ses_str}/"

mkdir -p ${ppl_work_dir}


##Load local software
#export PATH="${PATH}:${camino}bin/"


###SET ENVIRONMENTAL VARS NEEDED FOR ABOVE IF ANY
#export CAMINO_HEAP_SIZE=4000 #Increase the amount of RAM allocated to Camino


##Set file index from array
file_idx=$(printf "%02d" ${SLURM_ARRAY_TASK_ID})

###MODIFY SCRIPT TO RUN
./input_scripts/snum_ppl_module.sh ${cohort_name} ${ses} ${input_file}${file_idx}
