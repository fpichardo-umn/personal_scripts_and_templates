#!/bin/bash
###
#
#Useful functions to import to other scripts
#
#Created: 31032020 - FMP
###

exists_file_exit() {
	#Exit script if $1 does not exist
	if [ ! -e ${1} ]; then
		echo "${1} does not exist."
		echo "Exiting script."
		exit
	fi
}

exists_dir_exit() {
	#Exit script if $1 does not exist
	if [ ! -d ${1} ]; then
		echo "${1} does not exist."
		echo "Exiting script."
		exit
	fi
}

exists_file() {
	#Return 1 $1 does not exist else 0
	if [ ! -e "${1}" ]; then
		echo "${1} not found."
		return 1
	else
		return 0
	fi
}

exists_dir() {
	#Return 1 if $1 does not exist else 0
	if [ ! -d ${1} ]; then
		echo "${1} not found."
		return 1
	else
		return 0
	fi
}

exist_list() {
	#Return 1 if any file does not exist else 0
	file_cnt=${#}
	files_not_found=0
	ret_val=
	for file in ${@}; do
		exists_file ${file}
		ret_val=${?}
		files_not_found=$((files_not_found + ret_val))
	done

	if [ "${files_not_found}" -gt 0 ]; then
		return 1
	else
		return 0
	fi
}

aws_dl_file_if_nf() {
  #Download 1 and rename as 2 if 2 is not found
  if [ -f ${2} ]; then
    return
  elif [[ -z ${2} ]] || [[ -z ${1} ]]; then
    echo "One of the arguments is empty:"
    echo "1: ${1}"
    echo "2: ${2}"
    return
  fi
  
  aws s3 cp ${1} ${2}
}

aws_dl_dir_if_nf() {
  #Download 1 and rename as 2 if 2 is not found
  if [ -d ${2} ]; then
    return
  elif [[ -z ${2} ]] || [[ -z ${1} ]]; then
    echo "One of the arguments is empty:"
    echo "1: ${1}"
    echo "2: ${2}"
    return
  fi
  
  aws s3 cp ${1} ${2} --recursive
}

transfer_file_tier2_if_NF() {
  if [ ! -e "$3" ]; then
    #transfers from ep $1 to ep $2 and uses a label with valid characters
    label_name=$(basename $1)
    label_name=${label_name//-/ }
    label_name=${label_name//_/ }
    globus transfer $1 $2 --label "CLI ${label_name%%.*}" -s exists
  else
    echo Not transfering: $3 already exists...
  fi
}