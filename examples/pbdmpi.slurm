#!/bin/bash

#SBATCH --account=<project_id>
#SBATCH --partition=main
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=1:00:00

module purge
module load rstats/4.5.1

srun Rscript script.R
