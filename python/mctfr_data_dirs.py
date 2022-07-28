# -*- coding: utf-8 -*-
"""#Load important variables for directories
Var format:
	[ep]_location_desctiptions of directories_dir
	Endpoints for 2nd tier storage begin with ep

Created on Wed Jun  9 17:33:24 2021

@author: fpichard
"""

import os
import os.path as op

# NGDR Dirs
ngdr_space_dir = op.join('/', 'spaces', 'ngdr')
ngdr_ref_dir = op.join(ngdr_space_dir, 'ref-data')
ngdr_ref_mctfr_bids_dir = op.join(ngdr_ref_dir, 'mctfr', 'mri', 'bids')

# MSI SXW Dirs
msi_ssw_dir = op.join('/', 'home', 'syliaw', 'shared')
msi_ssw_ppl_dir = op.join(msi_ssw_dir, 'Pipelines')
msi_ssw_code_dir = op.join(msi_ssw_dir, 'General_Scripts')

msi_ssw_hcp_dir = op.join(msi_ssw_dir, 'hcp')
msi_ssw_hcp_der_dir = op.join(msi_ssw_hcp_dir, 'derivatives')
msi_ssw_hcp_der_dti_dir = op.join(msi_ssw_hcp_der_dir, 'DTI-1.0')
msi_ssw_hcp_der_fs_dir = op.join(msi_ssw_hcp_der_dir, 'FS-5.3.0')
msi_ssw_hcp_code_dir = op.join(msi_ssw_hcp_dir, 'code')
msi_ssw_hcp_work_dir = op.join(msi_ssw_hcp_code_dir, 'work_dir')
msi_ssw_hcp_temp_dir = op.join(msi_ssw_hcp_work_dir, 'temp')
msi_ssw_hcp_merge_dir = op.join(msi_ssw_hcp_work_dir, 'merge')
msi_ssw_hcp_docs_dir = op.join(msi_ssw_hcp_code_dir, 'docs')

#MSI smalone Dirs
msi_smm_dir = op.join('/', 'home', 'smalone', 'shared')
msi_smm_ppl_dir = op.join(msi_smm_dir, 'Pipelines')
msi_smm_code_dir = op.join(msi_smm_dir, 'General_Scripts')

#MSI thomaskm_02 Dirs
msi_esmf_dir = op.join('/', 'home', 'thomaskm_02', 'shared', 'ESMF_PROJ')
msi_esmf_data_dir = op.join(msi_esmf_dir, 'ESMF_PROJ_STAGING')

#Compute fmri Dirs
lts_fmri_dir = op.join('/', 'labs', 'mctfr-fmri')
lts_fmri_dti_dir = op.join(lts_fmri_dir, 'ESMF_DTI_output')
lts_fmri_data_dir = op.join(lts_fmri_dir, 'ESMF_PROJ_STAGING')

#Compute psyphys Dirs
lts_psyphys_dir = op.join('/', 'labs', 'mctfr-psyphys')
lts_psyphys_data_dir = op.join(lts_psyphys_dir, 'data')
lts_psyphys_raw_dir = op.join(lts_psyphys_data_dir, 'raw')
lts_psyphys_staging_dir = op.join(lts_psyphys_data_dir, 'staging')
lts_psyphys_main_dir = op.join(lts_psyphys_data_dir, 'main')
lts_psyphys_public_dir = op.join(lts_psyphys_data_dir, 'public')

#Compute burwellstudy Dirs
lts_sxb_dir = op.join('/', 'labs', 'burwellstudy')
lts_sxb_data_dir = op.join(lts_sxb_dir, 'data')
lts_sxb_projs_dir = op.join(lts_sxb_dir, 'projects')
lts_sxb_data_fmri_dir = op.join(lts_sxb_data_dir, 'fmri')

#Compute wilsonstudy Dirs
lts_ssw_dir = op.join('/', 'labs', 'wilsonstudy')
lts_ssw_cot_dir = op.join(lts_ssw_dir, 'CoT_MRI')
lts_ssw_cot_der_dir = op.join(lts_ssw_cot_dir, 'derivatives')
lts_ssw_cot_raw_dir = op.join(lts_ssw_cot_dir, 'RAW')
lts_ssw_cot_code_dir = op.join(lts_ssw_cot_dir, 'code')
lts_ssw_cot_der_dti_dir = op.join(lts_ssw_cot_der_dir, 'DTI-1.0')