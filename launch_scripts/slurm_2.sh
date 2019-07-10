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
# getting location of iDynoMICs
# for some reason this will return /storage/software/slurmd instead of /storage/software/iDynoMICs
echo $0
echo $(realpath $0)
echo $SLURM_SUBMIT_DIR
# check if not running with SLURM ($SLURM_SUBMIT_DIR shoul be empty in this case)
if [ -z "$SLURM_SUBMIT_DIR" ]
then
	# Echo "variable $SLURM_SUBMIT_DIR is empty, running as sh script"
	DYNO_SHARED_PATH=$(dirname $(dirname $(realpath $0)))
else
	# Echo "variable $SLURM_SUBMIT_DIR exists, running as sh script"
	DYNO_SHARED_PATH="${SLURM_SUBMIT_DIR}"
fi


#DYNO_SHARED_PATH=$(dirname $(dirname $(realpath $0)))
#DYNO_SHARED_PATH="${SLURM_SUBMIT_DIR}"

DYNO_FOLDER_NAME=$(basename ${DYNO_SHARED_PATH})
LOCAL_SOFTWARE_FOLDER='/scratch/'
DYNO_LOCAL_PATH=${LOCAL_SOFTWARE_FOLDER}${DYNO_FOLDER_NAME}
LAUNCH_SCRIPT=$DYNO_LOCAL_PATH/launch_scripts/launch.sh
# Need to purge local copy (if exists)
rm -rf ${DYNO_LOCAL_PATH}
# Copying the distro from shared folder
cp -r ${DYNO_SHARED_PATH} ${LOCAL_SOFTWARE_FOLDER}
# running calculations
sh $LAUNCH_SCRIPT
#
# copying calculation_results
mkdir /storage/results -p
#cp -R $DYNO_LOCAL_PATH/results/* /storage/results/
#
# removing distro
rm -rf "$DYNO_LOCAL_PATH"
