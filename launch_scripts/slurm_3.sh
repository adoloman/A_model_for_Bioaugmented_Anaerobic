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

DYNO_SHARED_FOLDER='/storage/software/iDynoMICs'

SCRATCH_FOLDER='/scratch'
LAUNCH_RELATIVE_LOCATION='launch_scripts/launch.sh'
STORAGE_FOLDER='/storage/results/'${SBATCH_JOB_ID}

DYNO_FOLDER_NAME=$(basename $DYNO_SHARED_FOLDER)
DYNO_LOCAL_FOLDER=$SCRATCH_FOLDER/$DYNO_FOLDER_NAME
LAUNCH_SCRIPT=$DYNO_LOCAL_FOLDER/$LAUNCH_RELATIVE_LOCATION

Echo "Purging local copy from previous run (if exists)"
rm -rf ${DYNO_LOCAL_FOLDER}

# Copying the distro from shared folder
cp -r ${DYNO_SHARED_FOLDER} ${DYNO_LOCAL_FOLDER}

# running calculations
sh $LAUNCH_SCRIPT

mkdir ${STORAGE_FOLDER} -p
cp -R ${DYNO_LOCAL_FOLDER}/results/* ${STORAGE_FOLDER}

rm -rf "$DYNO_LOCAL_PATH"




