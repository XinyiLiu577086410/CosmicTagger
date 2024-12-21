#!/bin/bash
#SBATCH --job-name=Task1
#SBATCH --output=Slurm-Output/Task1-%j.out
#SBATCH -N 1
#SBATCH -n 64

echo "=============RUN SCRIPT================="
cat $0
echo "========================================"

source env.sh
mpirun -n 64 -ppn 64 python bin/exec.py \
		run.id=task1 mode=iotest run.iterations=100  \
		+run.output_dir=CosmicTagger-Output/Task1 \
		data.data_directory=./data/  \
		run.minibatch_size=64

