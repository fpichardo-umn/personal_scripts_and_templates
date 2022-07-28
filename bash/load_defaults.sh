#!/bin/bash
###
#
#Load default variables into your script by running this one
#This script needs to be located with all the other scripts loaded.
#
#
#Created: FMP
#Last update: Make script call from it's location: 17032021 - FMP
#Add additional scripts: 15032019 - FMP
###

scripts_loc="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

load_dirs=${scripts_loc}/load_dirs.sh
module_checks=${scripts_loc}/module_check_funcs.sh
default_funcs=${scripts_loc}/default_funcs.sh

source ${load_dirs}
source ${module_checks}
source ${default_funcs}
