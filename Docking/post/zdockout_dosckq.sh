#!/usr/bin/bash
#Lrlrlr 270321 zdockout_extract.sh
#extract 2000 pdb docking results from ZDockResults.out and run DOCKQ calculation
#run on rosetta2 ubuntu@r2
#Input files: RECEPTOR_FILE, LIGAND_FILE, ZDockResults.out dockq.sh, create.pl, create_lig

for f in *
do
	cd "$f"
	mkdir 2k_pdb
	create.pl ZDockResults.out
	mv complex* 2k_pdb
	cp native.pdb dockq.sh 2k_pdb
	cd 2k_pdb 
	bash dockq.sh
	cp dockq.csv $f.dockq.csv
	mv $f.dockq.csv ../../
	cd ../../
done

