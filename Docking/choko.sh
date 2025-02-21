#!/usr/bin/bash
#Lrlrlr 250521 choko.sh
#Guide on how to run choko on nimbus (rosetta2)- pre and post processing.

#Installation. Run on conda.

#Input file. 
#1) 5zng_l_u.pdb (ligand of native) 
#2) 5zng_r_u.pdb (receptor of native) 
#3) 5zng.zd3.0.2.fg.fixed.out (54,000 from zdock runs not zrank)
#4) 2k_pdb (folder containing 2k/54k of zdock output)
#5) listBM.txt (file containing the name of the pdbid to be processed)

#Example in DS_results_extractedforCHOKO- 5zng.

#Run with 6fu9AB: rename files to: LIGAND_FILE, RECEPTOR_FILE, zdock.out

Edit the path in $SRC_DIR/Compute_scores.sh
edit listBM.txt 

#Command Pre run. Skip the Reformat_PDB_files.sh-->its only for decoys dataset.
cd 
conda activate choko
export PYTHONPATH=$PYTHONPATH:$PWD/DockingPP/src/
export SRC_DIR=$PWD/CHOKO
source $SRC_DIR/Compute_scores.sh #Run in directory where you want the output folder to be

#maybe i dont need the conda environment if they're its python 3.8 already.
source $SRC_DIR/Compute_scores.sh
bash Compute_scores.sh