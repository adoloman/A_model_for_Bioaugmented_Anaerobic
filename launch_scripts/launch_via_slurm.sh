#!/bin/bash
#SBATCH --nodes=1
#SBATCH --partition=partition_name

# don't forget to install JDK8 and povray.
# for Fedora: dnf -y install java-1.8.0-openjdk-devel povray

# the software is located on shared folder
shared_software_folder='/storage/software/iDynoMICs'
# local copy of software will be running at /scratch/iDynoMICs
local_working_folder='/scratch'

# Need to update local copy
rm -rf '/scratch/iDynoMICs'
cp -R $shared_software_folder $local_working_folder
sh '/scratch/iDynoMICs/launch_scripts/launch.sh'

cp -R /scratch/iDynoMICs/results/* /storage/results/
rm -rf '/scratch/iDynoMICs'
