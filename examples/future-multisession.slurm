#!/bin/bash

#SBATCH --account=<project_id>
#SBATCH --partition=main
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=2G
#SBATCH --time=5:00

module purge
module load r/4.5.3

Rscript future-multicore.R
