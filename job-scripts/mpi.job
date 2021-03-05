#!/bin/bash

#SBATCH --nodes=2
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3GB
#SBATCH --time=00:20:00
#SBATCH --account=<account_id>

module purge
module load gcc/8.3.0
module load openblas/0.3.8
module load openmpi/4.0.2
module load pmix/3.1.3
module load r/4.0.0

srun --mpi=pmix_v2 -n $SLURM_NTASKS Rscript --vanilla script.R
