#!usr/bin/bash
#Lrlrlr 060921 postDS4dockq.sh
#Process DS output from docking using raw folder outputs.
#To extract PDB structures from zdock.out OR zdockResults.out
#Followed by extraction of poses for post-docking processing- DockQ.

#Delete all files except those 4 and place in main directory.
#1extract.sh

for f in DockProteinsZDOCK_2021_*
do
	cd "$f"
	cd Input && cp *.dsv ../ && cd ../ && cd Output && cp *.out *.log ../ && cd ../ && rm -r Input Output
	cd ../
done

#2copycreate.sh. copy create* into all folders

for f in *; do [ -d "$f" ] && cp create* "$f" ; done

#manual transfer of RECEPTOR_FILE, LIGAND_FILE--NO way of automating this. and renaming.
#manual fixing of .out files. maybe i can automate this.


#Analyse 54,000 from zdock.out (the long way)
#remember to delete number 0 in line RECEPTOR_FILE & LIGAND_FILE (.out file)

for f in DockProteinsZDOCK_2021_*
do
	cd "$f"
	cp zdock.out zdock.outORI && cp ZDockResults.out ZDockResults.outORI
	mkdir 54k_zdock && mkdir 2k_zrank && cp zdock.out 54k_zdock && cp ZDockResults.out 2k_zrank && cp *FILE 54k_zdock && cp *FILE 2k_zrank && cp *_FILE 54k_zdock && cp *_FILE 2k_zrank && cp create* 2k_zrank && cp create* 54k_zdock
	cd ../
done


#runtime. 54k starts 552pm-557pm. 5mins. 2k ~3seconds.
create.pl zdock.out
create.pl ZDockResults.out

#run DockQ. requires native complex. check from previous DockQ runs. use those, i remember requires fixing of chain letters.
pdbfetch pdbid


