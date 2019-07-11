#!/bin/bash
#SBATCH --nodes=1
#SBATCH --partition=kyiv
#
# don't forget to install JDK8 and povray.
# for Fedora: dnf -y install java-1.8.0-openjdk-devel povray
#
# Assuming:
# iDynoMICs software is located on shared folder
# local copy of software will be running at /scratch/iDynoMICs
# /iDynoMICs/src/SearchEngine/Constans.java contains already fixed paths for final location of protocols, etc.
#
# Algorithm:
# 1) Identify location of script and iDynoMICs distro
# 2) Check if computational node contains any leftovers from previous runs
# 3) Copy from main storage to a local storage of computational node
# 4) Run at computational Node
# 5) Copy calculation results from compute node to centralized storage
# 6) Purge local distro

# Check if script is launched from SLURM or BASH
# SLURM creates variable $SLURM_JOB_ID, thus it shouldn't be empty
if [ -n $SLURM_JOB_ID ];  then
	# get original location of launching script
	THEPATH=$(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
else
	# otherwise it is started from bash and obtain location in normal way
	THEPATH=$(realpath $0)
fi

# get location of distro at shared storage
DYNO_SHARED_FOLDER=$(dirname $(dirname "${THEPATH}"))

SCRATCH_FOLDER='/scratch'
LAUNCH_RELATIVE_LOCATION='launch_scripts/launch.sh'
STORAGE_FOLDER='/storage/results/'${SBATCH_JOB_ID}

DYNO_FOLDER_NAME=$(basename $DYNO_SHARED_FOLDER)
DYNO_LOCAL_FOLDER=$SCRATCH_FOLDER/$DYNO_FOLDER_NAME
LAUNCH_SCRIPT=$DYNO_LOCAL_FOLDER/$LAUNCH_RELATIVE_LOCATION

# Purging local copy from previous run (if exists)
rm -rf ${DYNO_LOCAL_FOLDER}
# Copying the distro from shared folder
cp -r ${DYNO_SHARED_FOLDER} ${DYNO_LOCAL_FOLDER}
# running calculations
sh $LAUNCH_SCRIPT
# create folder on central storage for transfering computation results
mkdir ${STORAGE_FOLDER} -p
# copy results
cp -R ${DYNO_LOCAL_FOLDER}/results/* ${STORAGE_FOLDER}
# prge local copy of distro
rm -rf "$DYNO_LOCAL_PATH"
