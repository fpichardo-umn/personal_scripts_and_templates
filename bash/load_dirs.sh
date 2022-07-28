#!/bin/bash
###
#
#Load important variables for directories
#Var format:
#	[ep]_location_desctiptions of directories_dir
#	Endpoints for 2nd tier storage begin with ep
#
#Created: FMP
#Last update: 15032019 - FMP
##

#NGDR Dirs
ngdr_space_dir="/spaces/ngdr/"
ngdr_ref_dir=${ngdr_space_dir}"ref-data/"
ngdr_ref_mctfr_bid_dir=${ngdr_ref_dir}"mctfr/mri/bids/"
ngdr_ukbb_bids_dir="${ngdr_space_dir}workspaces/smalone/biobank_ws/R21/bids/"

#HCP Dirs
aws_hcp_dir="s3://hcp-openaccess/"
aws_hcp_data_dir=${aws_hcp_dir}HCP_1200/

#MSI syliaw Dirs
msi_ssw_dir="/home/syliaw/shared/"
msi_ssw_ppl_dir=${msi_ssw_dir}Pipelines/
msi_ssw_code_dir=${msi_ssw_dir}General_Scripts/

msi_ssw_hcp_dir=${msi_ssw_dir}hcp/
msi_ssw_hcp_der_dir=${msi_ssw_hcp_dir}derivatives/
msi_ssw_hcp_der_dti_dir=${msi_ssw_hcp_der_dir}DTI-1.0/
msi_ssw_hcp_der_fs_dir=${msi_ssw_hcp_der_dir}FS-5.3.0/
msi_ssw_hcp_code_dir=${msi_ssw_hcp_dir}code/
msi_ssw_hcp_work_dir=${msi_ssw_hcp_code_dir}work_dir/
msi_ssw_hcp_temp_dir=${msi_ssw_hcp_work_dir}temp/
msi_ssw_hcp_merge_dir=${msi_ssw_hcp_work_dir}merge/
msi_ssw_hcp_docs_dir=${msi_ssw_hcp_code_dir}docs/

#MSI smalone Dirs
msi_smm_dir="/home/smalone/shared/"
msi_smm_ppl_dir=${msi_smm_dir}Pipelines/
msi_smm_code_dir=${msi_smm_dir}General_Scripts/

#MSI thomaskm_02 Dirs
msi_esmf_dir="/home/thomaskm_02/shared/ESMF_PROJ/"
msi_esmf_data_dir=${msi_esmf_dir}ESMF_PROJ_STAGING/

#Compute fmri Dirs
lts_fmri_dir="/labs/mctfr-fmri/"
lts_fmri_dti_dir=${lts_fmri_dir}ESMF_DTI_output/
lts_fmri_data_dir=${lts_fmri_dir}ESMF_PROJ_STAGING/

#Compute psyphys Dirs
lts_psyphys_dir="/labs/mctfr-psyphys/"
lts_psyphys_data_dir=${lts_psyphys_dir}data/
lts_psyphys_raw_dir=${lts_psyphys_data_dir}raw/
lts_psyphys_staging_dir=${lts_psyphys_data_dir}staging/
lts_psyphys_main_dir=${lts_psyphys_data_dir}main/
lts_psyphys_public_dir=${lts_psyphys_data_dir}/public/

#Compute burwellstudy Dirs
lts_sxb_dir="/labs/burwellstudy/"
lts_sxb_data_dir=${lts_sxb_dir}data/
lts_sxb_projs_dir=${lts_sxb_dir}projects/
lts_sxb_data_fmri_dir=${lts_sxb_data_dir}fmri/

#Compute wilsonstudy Dirs
lts_ssw_dir="/labs/wilsonstudy/"
lts_ssw_cot_dir=${lts_ssw_dir}CoT_MRI/
lts_ssw_cot_der_dir=${lts_ssw_cot_dir}derivatives/
lts_ssw_cot_raw_dir=${lts_ssw_cot_dir}RAW/
lts_ssw_cot_code_dir=${lts_ssw_cot_dir}code/
lts_ssw_cot_der_dti_dir=${lts_ssw_cot_der_dir}DTI-1.0/

#2nd Tier Endpoints
if type "globus" >& /dev/null; then

    #tier 2 for hcp
    ep_t2=`globus endpoint search 'umnmsi@globusid.org' | grep tier2 | awk '{print $1}'`
    	
    #2nd Tier Dirs
    ep_t2_hcp_dir=${ep_t2}:mctfr-hcp/
    ep_t2_hcp_der_dir=${ep_t2_hcp_dir}derivatives/
    ep_t2_hcp_der_dti_dir=${ep_t2_hcp_der_dir}DTI-1.0/
    ep_t2_hcp_der_fs_dir=${ep_t2_hcp_der_dir}FS-5.3.0/

    #tier2 mctfr-psyphys
    mctfr_psyphys=`globus endpoint search 'mctfr-psyphys' | grep mctfr | awk '{print $1}'`

    #Dirs
    ep_t2_psyphys_raw_dir=${mctfr_psyphys}:raw/
    ep_t2_psyphys_raw_orig_dir=${ep_t2_psyphys_raw_orig_dir}origlab/
    ep_t2_psyphys_raw_biosemi_dir=${ep_t2_psyphys_raw_orig_dir}biosemi/
    
    
    #2nd Tier MSI Dirs
    #Requires syliaw as the primary group!
    ep_msi_home=`globus endpoint search 'umnmsi@globus' | grep home | awk '{print $1}'`
    
    ep_msi_ssw_dir=${ep_msi_home}:../shared/
    ep_msi_ssw_hcp_dir=${ep_msi_ssw_dir}hcp/
    ep_msi_ssw_hcp_der_dir=${ep_msi_ssw_hcp_dir}derivatives/
    ep_msi_ssw_hcp_der_dti_dir=${ep_msi_ssw_hcp_der_dir}DTI-1.0/
    ep_msi_ssw_hcp_der_fs_dir=${ep_msi_ssw_hcp_der_dir}FS-5.3.0/

fi
