#!/bin/bash
#SBATCH --job-name=__JOB_NAME__
#SBATCH --partition=gpu_a100
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --time=48:00:00
#SBATCH --output=md_%j.log

module load cuda/12.2
source ~/miniconda3/etc/profile.d/conda.sh
conda activate md

cd __PROJECT_DIR__/06_md
gmx mdrun -deffnm md \
    -nb gpu -pme gpu -bonded gpu -update gpu \
    -pin on -ntmpi 1 -ntomp 8 \
    -v -cpi -cpo state.cpt
