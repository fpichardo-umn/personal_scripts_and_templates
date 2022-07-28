#!/bin/bash
###
#
#Return cohort specific dirs
#
#Created: 30062010 - FMP
###

################################################################################
# Help                                                                         #
################################################################################
Help()
{
  # Display Help
  echo "Return cohort specific dirs"
  echo 
  echo "usage: get_cohort_dirs.sh request_key cohort"
  echo "   request_key:  key used to determine which directory to return. See key_to_dirs.tsv for the key-cohort-value mappings."
  echo "   cohort: valid cohort (found in first line of key_to_dirs.tsv)"
  echo "get_cohort_dirs.sh main hcp"
  echo
}
################################################################################
# Get the options
while getopts ":h" option; do
  case $option in
    h) # display Help
      Help
      exit;;
    \?) # incorrect option
      echo "Error: Invalid option"
      exit;;
  esac
done
################################################################################
################################################################################
# Main program                                                                 #
################################################################################

# Vars
request_key=$(echo "${1}" | tr '[:upper:]' '[:lower:]')
cohort=$(echo "${2}" | tr '[:upper:]' '[:lower:]')

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
table_file="${SCRIPT_DIR}/key_to_dirs.tsv"

. "${SCRIPT_DIR}/load_defaults.sh"

table_max_coln=$(head -n1 ${table_file} | awk '{print NF}')
table_max_rown=$(cat ${table_file} | wc -l)

# Check for table file
if [ ! -f ${table_file} ]; then
  echo "$(basename ${table_file}) was not found in ${SCRIPT_DIR}. Exiting."
  exit 1
fi

cohort_col_match=$(head -n1 ${table_file} | tr '\t' '\n' | grep -nw "${cohort}" | cut -d':' -f1)
if [[ ${cohort_col_match} -lt 2 ]] || [[ ${cohort_col_match} -gt ${table_max_coln} ]]; then
  echo "${cohort} is not a valid cohort. See relevant cohort matches:"
  head -n1 ${table_file} | awk '{for (i=2; i<=NF; i++) print $i}'
  echo "Exiting."
  exit 1
fi

request_row_match=$(awk '{print $1}' ${table_file} | grep -wn ${request_key} | cut -d':' -f1)
if [[ ${request_row_match} -lt 2 ]] || [[ ${cohort_col_match} -gt ${table_max_rown} ]]; then
  echo "${request_key} is not a valid request key. See relevant key matches:"
  tail -n +2 ${table_file} | awk '{print $1}'
  echo "Exiting."
  exit 1
fi

query_val=$(sed -n -e ${request_row_match}p ${table_file} | tr '\t' '\n' | sed -n -e ${cohort_col_match}p)

if [[ ${request_row_match} -eq 2 ]]; then
  # Main dirs are stored as the variable and must be evaulated before passing it on
  eval "echo ${query_val}" 
else
  echo ${query_val}
fi