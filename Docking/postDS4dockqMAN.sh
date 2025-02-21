#!usr/bin/bash
#Lrlrlr 060921 postDS4dockq.sh
#Process DS output from docking using raw folder outputs.
#To extract PDB structures from zdock.out OR zdockResults.out
#Followed by extraction of poses for post-docking processing- DockQ.

#Folder structure name. Only 4 files are required to be retained from each folder.
DockProteinsZDOCK_2021_*
Input
│   ├── 7NMMH_prepMin.dsv	#Required to capture file name (only first 4)
│   ├── 7NMMP_prepMin_reset.dsv	#Required to capture file name (only first 4)
│   └── Protocol.pr_xml
└── Output
    ├── Output.log
    ├── Report
    │   └── images
    │       └── icons
    │           ├── minus.png
    │           └── plus.png
    ├── Report.htm
    ├── ViewResults.ds_pl
    ├── ZDockResults.dsv
    ├── ZDockResults.out	#required ZRANK output of 2000
    ├── ZDockResults_all.dsv
    ├── zdock.log
    └── zdock.out	#required ZDOCK output of 54,000

#Delete all files except those 4 and place in main directory.

cd DockProteinsZDOCK_2021_*
cd Input && cp *.dsv ../ && cd ../ && cd Output && cp *.out *.log ../ && cd ../
rm -r Input Output

#extract pdbs

#A)Extraction pack:
#Input files: RECEPTOR_FILE, LIGAND_FILE, ZDockResults.out dockq.sh, create.pl, create_lig
#B) Transfer receptor and ligand files into respective folders. They are the input pdb feeded in to DS zdock.
#C:\Users\linarozano\OneDrive - Curtin University of Technology Australia\Docking_inputFiles\200_GB_BOUND_resetCoor #will be the same input to run nimbus zdock

#Analyse 54,000 from zdock.out (the long way)
#remember to delete number 0 in line RECEPTOR_FILE & LIGAND_FILE (.out file)
cp zdock.out zdock.outORI && cp ZDockResults.out ZDockResults.outORI
mkdir 54k_zdock && mkdir 2k_zrank
cp zdock.out 54k_zdock && cp ZDockResults.out 2k_zrank && cp create* 54k_zdock && cp create* 2k_zrank && cp *FILE 54k_zdock && cp *FILE 2k_zrank

#runtime. 54k starts 552pm-557pm. 5mins. 2k ~3seconds.
create.pl zdock.out
create.pl ZDockResults.out

#run DockQ. requires native complex. check from previous DockQ runs. use those, i remember requires fixing of chain letters.



