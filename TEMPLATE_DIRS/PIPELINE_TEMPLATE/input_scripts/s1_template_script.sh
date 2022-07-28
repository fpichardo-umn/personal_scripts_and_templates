#!/bin/bash
####
#
#Script Description
# Args:
#   cohort, sesssion number, and path to subjects list
#   Final argument should be path to subjects list.
#
##Created: 09032021 - FMP
####


##Check for required modules
#These can be found in module_check_funcs (loaded by load_defaults)
#globus_check
#fsl_check
#camino_check
#freesurfer_check
#python3_check
#afni_check
#ants_check
#c3d_check


##Functions
#Define functions that you will use here


##Important Bids Variables
unset ses_num
unset cohort_name
cohort_name="$(echo "${1}" | awk '{print tolower($0)}')"
ses_num="${2}"

# Some cohorts have no session number
# If ses_num is empty and is not NA,
#   that part of the bids variable name will be empty (ses)
#   that session directory variable name will be empty (ses_dir)
if [ ${ses_num} ] && [ "${ses_num}" != "NA" ]; then
  ses_dir="ses-${ses_num}/" # ses dir (without _)
  ses="_ses-${ses_num}"     # ses for variable names (needs _)
  ses_str="_${ses_num}"     # ses for work dir
else
  ses=""
  ses_dir=""
  ses_str=""
fi


## Define subjects array
subjects=( "${@: -1}" ) # Used for testing on one sub
#mapfile -t subjects < ${@: -1} # General use
#sub_file=${@: -1}                  #\ Used for creating separate stats files per batch
#mapfile -t subjects < ${sub_file}  #/



## Dirs defined using load_defaults from pbs script
#Make sure that this points to the correct cohort directory
#Make sure that the cohort names are correct for the given cohort!
#From load_defaults, points to where cohort data is stored
get_cohort_script_path="../General_Scripts/get_cohort_dirs.sh"
main_path_dir=$(eval "${get_cohort_script_path} main ${cohort_name}")
cohort_dir="${main_path_dir}${cohort_name}/" 
cohort_der_dir="${cohort_dir}derivatives/"

## Derivatives
fs_dir_str=$(eval "${get_cohort_script_path} fs5 ${cohort_name}")
anat_dir_str=$(eval "${get_cohort_script_path} anat ${cohort_name}")
dti_dir_str=$(eval "${get_cohort_script_path} dti ${cohort_name}")

# Define der dirs
fs_dir="${cohort_der_dir}${fs_dir_str}/"
fs_anat_dir="${cohort_der_dir}${anat_dir_str}/"
dti_dir="${cohort_der_dir}${dti_dir_str}/"
data_dir=${cohort_dir}


## Pipeline dirs and files
ppl_name=$(basename $(pwd))
ppl_work_dir="../work_dir/${ppl_name}_${cohort_name}${ses_str}/"
ppl_docs_dir="./docs/"

mkdir -p ${ppl_docs_dir}


## Important variables/files
templates_dir="../templates/HBT_ritchey/MNI152_1mm_fsl/"

labels="${ppl_docs_dir}roi_files"


## Create stats file
today=$(date +"%m_%d_%Y")

# If running all subs of interest
stats_doc="${ppl_work_dir}${cohort_name}${ses}_dwi_space-T1w_desc-${annot_str}_mean_FA_${today}.tsv"

#For running separate batches of subs
#stats_file_idx=$(echo "${sub_file: -2}") #Use the last two chars
#stats_doc="${ppl_work_dir}${cohort_name}${ses}_dwi_space-T1w_desc-mean_FA_${stats_file_idx}_${today}.tsv"


## Init files
#echo "subid body_lh body_rh head_lh head_rh tail_lh tail_rh phc_lh  phc_rh  prc_lh  prc_rh" > ${stats_doc}

##         MAIN PIPELINE
#Apply pipeline to each sub in list
for sub in ${subjects[@]}; do
    
  bids_id="sub-"${sub}
  echo "Working on ${bids_id}..."

  
  ## Subject Specific Dirs/Vars
  #List all dirs/files that the sub requires for this pipeline
  #Test that these dirs/files exist before running
  
  #Dirs
  sub_fs_dir="${fs_dir}${bids_id}${ses}/"
  sub_fs_masks_dir="${sub_fs_dir}masks/"
  sub_fs_xfm_dir="${sub_fs_dir}xfm/"

  #Files
  xfm_mni_to_fs="${sub_fs_xfm_dir}${bids_id}${ses}_from-MNI_to-T1w_mode-image_xfm.nii.gz"
  sub_ref_img="${sub_fs_dir}${bids_id}${ses}_t1w_desc-wmparc.nii.gz"

  #Test that these files exist
  exist_list ${sub_fs_dir} ${sub_fs_masks_dir} ${sub_fs_xfm_dir} ${xfm_mni_to_fs} ${sub_ref_img}
  if [ "${?}" -eq 1 ]; then
    echo "Files missing for ${bids_id}. See above output. Skipping."
    continue
  fi

  
  ## Files to create
  #List all dirs/files that will be created for this pipeline
  sub_dwi_mask="${sub_dti_dir}masks/${bids_id}_ses-${ses}_dwi_desc-brain_mask.nii.gz"
  sub_dti_masked_file="${sub_dwi_dir}${bids_id}_ses-${ses}_dwi_desc-masked.nii.gz"
  sub_apx_dti_file="${sub_apx_dir}${bids_id}_ses-${ses}_data.nii.gz"
  
  #Create array of files to create if they all have similar names
  declare -a sub_roi_files
  
  for roi in ${sub_rois[@]}; do #sub_rois declared outside of loop!
    #Accumulate sub roi filenames
    sub_roi_files+=("${sub_fs_masks_dir}${bids_id}${ses}_t1w_desc-${roi}_mask.nii.gz")
  done
  
  for file_idx in ${!sub_cache_tsv_files[*]}; do
    mv ${sub_cache_file} ${sub_denoised_file}
  done
  
  
  ###START
  
  ###
  #     PIPELINE
  ###
  
  # SKIP CONDITION
  ## Test if sub already has data and skip them. Useful to easily re-run batches without too much moding.
  
  
  ###DONE
  echo "Done with ${bids_id}."

done

echo "Done with PPL_NAME."
