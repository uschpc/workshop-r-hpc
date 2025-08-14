#!/bin/bash

#SBATCH --account=<project_id>
#SBATCH --partition=main
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=1:00:00
#SBATCH --array=1-3

module purge
module load rstats/4.5.1

echo "Task ID: $SLURM_ARRAY_TASK_ID"

Rscript array.R
