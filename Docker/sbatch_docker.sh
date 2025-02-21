#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --time=00:10:00
#SBATCH --partition=workq
#SBATCH --export=NONE
 
module load shifter/18.06.00
 
shifter pull tmalign:latest
srun --export=all -n 1 shifter tmalign:latest TMalign /scratch/pawsey0110/lrozano/Convergence_test/test_dockerTMalign/S_00000227.pdb /scratch/pawsey0110/lrozano/Convergence_test/test_dockerTMalign/template.pdb -o TM.sup -m matrix.txt > models_template.log