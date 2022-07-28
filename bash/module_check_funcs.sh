#!/bin/bash
###
#
#Functions to test that modules are loaded before continuing with script.
#These functions will exit the script.
#
#To use, add the following line to your scipt:
#	source ${abs_path}/module_check_funcs.sh
#This loads the functions below. To use them, just type the function name into the script.
#You can suggest a specific version to use by passing it along when you call the function:
#	fsl_check 5.3.0
#
#Created: FMP
#Last update: 15032019 - FMP
###


#Suggest version Number
suggest_version () {
	echo Make sure to use/load version $1.
}


#Make sure that globus is loaded
globus_check () {
	if ! type "globus" >& /dev/null; then
        	echo "globus is not loaded. Please load before running this script."
	        echo "module load globus-cli"
	        echo "Make sure to login."
	        echo "globus login"
		echo "Make sure the endpoint you're trying to use is activated."
		echo "globus endpoint activate --web ENDPOINT_ID"
		echo "Exiting script."
        	exit
	fi
}

#Make sure that fsl is loaded
fsl_check () {
	if ! type "fslmaths" >& /dev/null; then
        	echo "FSL is not loaded. Please load before running this script."
	        echo "module load fsl"

		if [ $# -ne 0 ]; then
			suggest_version $1
		fi

	        echo "Exiting script."
        	exit
	fi
}

#Make sure that Camino is loaded
camino_check () {
	if ! type "fsl2scheme" >& /dev/null; then
        	echo "Camino is not loaded. Please load before running this script."
	        echo "module load camino"
	        echo "Exiting script."
        	exit
	fi
}

#Make sure Freesurfer is loaded
freesurfer_check () {
	if [ -z "$FREESURFER_HOME" ] ; then
        	echo "FREESURFER_HOME does not exist!"
		echo "Please load the FreeSurfer module before running this script."

                if [ $# -ne 0 ]; then
                        suggest_version $1
                fi

		echo "Exiting script."
	        exit
	fi
}

#Make sure afni is loaded
afni_check () {
  if ! type "afni" >& /dev/null; then
    echo "Afni is not loaded. Please load before running this script."
            echo "module load afni"
            echo "Exiting script."
    exit
  fi
}

#Switch FS version
switch_fs_version () {

	freesurfer_check

	if [ ! $(basename ${FREESURFER_HOME}) = $1 ] ; then
		echo "Wrong version of FreeSurfer loaded -- switching to verison $1"
	        export FREESURFER_HOME=${FREESURFER_HOME}/../$1/
		echo $FREESURFER_HOME
        	source ${FREESURFER_HOME}/FreeSurferEnv.sh
	else
        	echo "Running using FreeSurfer version $1"
	fi
}

#Make sure that python3 is loaded
python3_check () {
        if ! type "python3" >& /dev/null; then
                echo "Python version 3 is not loaded. Please load before running this script."
                echo "module load python3"
                echo "Exiting script."
                exit
        fi
}

#Make sure that ants is loaded
ants_check () {
  if ! type "antsUtilitiesTesting" >& /dev/null; then
    echo "ANTS is not loaded. Please load before running this script."
    echo "module load ants"
    echo "Exiting script."
    exit
  fi
}

#Make sure that afni is loaded
afni_check () {
  if ! type "afni_history" >& /dev/null; then
    echo "AFNI is not loaded. Please load before running this script."
    echo "module load afni"
    echo "Exiting script."
    exit
  fi
}

#Make sure that ants is loaded
c3d_check () {
  if ! type "c3d" >& /dev/null; then
    echo "C3D is not loaded. Please load before running this script."
    echo "module load c3d"
    echo "Exiting script."
    exit
  fi
}