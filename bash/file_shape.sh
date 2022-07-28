#!/bin/bash
####
#
#Get [number of rows, number of columns] for a file
#
##Created: 170320201 - FMP
####

file=${1}

nrow=$(cat ${file} | wc -l)
ncol=$(cat ${file} | awk '{print NF}' | head -n1)

echo [ ${nrow}, ${ncol} ]