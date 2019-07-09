#!/bin/bash
#SBATCH --nodes=1
#SBATCH --partition=partition_name

# don't forget to install JDK8 and povray.
# for Fedora: dnf -y install java-1.8.0-openjdk-devel povray
# make sure this file is in UTF-8 (use dos2unix utility)

# Assuming:
# 1) iDynoMICs software is located on shared folder
# 2) local copy of software will be running at /scratch/iDynoMICs
# 3) /iDynoMICs/src/SearchEngine/Constans.java contains already fixed paths for final location of protocols, etc.

# getting location of iDynoMICs
DYNO_SHARED_PATH=$(dirname $(dirname $(realpath $0)))
DYNO_FOLDER_NAME=$(basename ${DYNO_SHARED_PATH})
LOCAL_SOFTWARE_FOLDER='/scratch'
DYNO_LOCAL_PATH=${LOCAL_SOFTWARE_FOLDER}'/'${DYNO_FOLDER_NAME}

echo $DYNO_SHARED_PATH
echo $DYNO_FOLDER_NAME
echo $LOCAL_SOFTWARE_FOLDER
echo $DYNO_LOCAL_PATH

# Need to purge local copy (if exists)
echo "rm -rf ${DYNO_LOCAL_PATH}"
rm -rf ${DYNO_LOCAL_PATH}
# Copying the distro from shared folder
echo "${DYNO_SHARED_PATH} ${LOCAL_SOFTWARE_FOLDER}"
cp -r ${DYNO_SHARED_PATH} ${LOCAL_SOFTWARE_FOLDER}
# running calculations
echo "$DYNO_LOCAL_PATH'/launch_scripts/launch.sh'"
sh $DYNO_LOCAL_PATH'/launch_scripts/launch.sh'

# copying calculation_results
mkdir /storage/results -p
cp -R $DYNO_LOCAL_PATH'/results/*' /storage/results/*
# removing distro
rm -rf "$DYNO_LOCAL_PATH"
