#!/bin/bash
#SBATCH --job-name=Task1
#SBATCH --output=Slurm-Output/Task1-%j.out
#SBATCH -N 1
#SBATCH -n 64
#SBATCH --gres=gpu:2

if [ ! -d /tmp/${USER} ]; then
	mkdir /tmp/${USER}/
fi
cp ./data/* /tmp/${USER}/

echo "=================DU==================="
du -sh /tmp/${USER}/*
echo "=================LS==================="
ls -l /tmp/${USER}/*
echo "======================================"
echo "=============RUN SCRIPT================="
cat $0
echo "========================================"
source env.sh
mpirun -n 1 -ppn 64 python bin/exec.py \
		run.id=task1 mode=iotest run.iterations=100  \
		+run.output_dir=CosmicTagger-Output/Task1 \
		data.data_directory=/tmp/${USER}/  \
		run.minibatch_size=64
rm /tmp/${USER}/*	
