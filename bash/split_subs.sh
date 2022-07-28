#!/bin/bash
#
#Split a subs file (1) in pwd into groups of (3) and save the output in docs dir
#as (2) starting from number (4)
#	./split_subs.sh subs_a subs_a 20 1
#

split -l ${3} --numeric-suffixes=${4} -a 2 ${1} ${2}
