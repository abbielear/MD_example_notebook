#!/bin/bash
#SBATCH --partition test  ##Using test partition b/c v. slow queue for compute  
#SBATCH --job-name=M1A5_6NB_TS
#SBATCH --output   M1A5_6NB_TS
#SBATCH --time=1:00:00       # Walltime
#SBATCH --nodes=1            # number of tasks
#SBATCH --ntasks-per-node=12 # number of tasks per node
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --account=ptch000721
 
# 1. Load module(s)
module load apps/amber/20
module add lang/intel-parallel-studio-xe/2020

# 2. Set directories
cd /user/work/qz22231/230303_notebook_example 

# 3. Define variables
input_folder=1_Equilibrate_example/1A5_6NB_TS/1A5_6NB_TS
topology_filepath=0_Parent_example/1A5_6NB_TS
structure_filepath=1_Equilibrate_example/1A5_6NB_TS/1A5_6NB_TS
output_filepath=${structure_filepath}_min

# 4. Run Jobs

srun -n 12 --cpu-bind=cores --mpi=pmi2 sander.MPI -O -i ${input_folder}_min.in -o $output_filepath.log -p $topology_filepath.parm7         -c $topology_filepath.rst7 -x $output_filepath.nc -r $output_filepath.rst7 -inf $output_filepath.mdinf
