#### MIBM_fit_model.sh START ####
## 1) Change the above line to match your file name

#!/bin/bash
#$ -cwd
# error = Merged with joblog
## 2) The line below will make it so that your job saves what would
## normally go in the R console as a file called "joblog.thejobnumberinthecluster
#$ -o joblog.$JOB_ID
#$ -j y
## 3 ) Edit the line below as needed:
## h_rt is the max time your job will run for, h_data is the max amount of memory each core will use.
#$ -l h_rt=24:00:00,h_data=2G
## 4) Modify the parallel environment
## and the number of cores as needed (currently set to 1):
#$ -pe shared 1
# 5) Email address to notify
#$ -M $kseager@ucla.edu
# Notify when
##$ -m bea

# Load the job environment (leave this alone mostly):
. /u/local/Modules/default/init/modules.sh

## 7) Edit the lines below as needed:

#Load in:
module load intel/18.0.4
# Load version of R that matches packages
module load R/4.1.1
# Load additional packages if needed
module load proj
module load gdal

## 8) substitute the command to run your code
## in the two lines below, make sure you point to the correct directory!:
echo '/u/home/k/kseager/R/M-IBM/scripts/sim_fit/run_simulation.R'
Rscript /u/home/k/kseager/R/M-IBM/scripts/sim_fit/run_simulation.R

# echo job info on joblog (leave this be):
echo "Job $JOB_ID ended on:   " `hostname -s`
echo "Job $JOB_ID ended on:   " `date `
echo " "

## 9) Change this to fit your file name
#### MIBM_fit_model.sh STOP ####
