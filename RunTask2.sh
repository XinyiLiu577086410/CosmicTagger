#!/bin/bash
#SBATCH --job-name=Task2
#SBATCH --output=Slurm-Output/Task2-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=6
#SBATCH --gres=gpu:2
#SBATCH --ntasks-per-node=3

# maybe nessary if --gres is not used
##SBATCH --exclusive

echo "=============RUN SCRIPT================="
cat $0
echo ""
echo "========================================"

source env.sh
conda init 
conda activate TrCosmictagger
export HYDRA_FULL_ERROR=1
mpirun -n 6 -ppn 3 python bin/exec.py \
		--config-name SCC_21.yaml \
		run.id=task2 \
		run.iterations=1000  \
		data.downsample=2 \
		framework=torch \
		run.minibatch_size=12 \
		run.distributed=true \
		data.data_directory=/data/Training/ \
		+run.output_dir=CosmicTagger-Output/Task2