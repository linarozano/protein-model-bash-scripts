#!/bin/bash
#Lrlrlr 280719 pymol_pdb2pngSingle.sh edited 140919
#Extract cluster centroids.pdbs from MasterPDB folder

for x in ./*.pdb
do
	echo "load $x;" > $x.pml	#creating pymol script
	echo "set ray_opaque_background, on;" >> $x.pml
	echo "show cartoon;" >> $x.pml
	echo "color purple, ss h;" >> $x.pml
	echo "color yellow, ss s;" >> $x.pml
	echo "ray 380,380;" >> $x.pml
	echo "png $x.png;" >> $x.pml
	echo "quit;" >> $x.pml
	pymol -qxci $x.pml
	rm -rf $x.pml $x.pdb
done


