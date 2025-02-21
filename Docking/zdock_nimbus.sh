#!/usr/bin/bash
# Lrlrlr 150621 zdock_nimbus.sh
#Simplified script to run zdock and zrank on nimbus

#ON NIMBUS
cd /home/ubuntu/zdock3.0.2_linux_x64 
cd /home/ubuntu/zdock3.0.2_linux_mpi
export LD_LIBRARY_PATH=$PWD:$LD_LIBRARY_PATH
./mark_sur 
copy mark_sur, uniCHARMM, block.pl to the directory you want to run zdock

#mark each atoms (okay if have hetatom or hydrogens, but better without)
mark_sur receptor.pdb receptor_m.pdb
mark_sur ligand.pdb ligand_m.pdb

zdock -R receptor_m.pdb -L ligand_m.pdb -N 54000 -D -o zdock.out

#zrank
#edit zdock.out ligand and receptor file to refer to the one with H
cp zdock.out zdockwH.out--makes no difference
zrank zdockwH.out 1 54000 

#merge zdock zrank outputs
sed '1,5d' zdockwH.out > log1 #remove top5 lines from zdock.out
cat *zr.out | awk '{print $2}' > log2
paste log1 log2 | column -s $'\t' -t > log3
sort -nk 8 log3 > log4	#sort based on zrank
head -5 zdockwH.out > log5 #merge with header so can extract later
cat log5 log4 > zdockzrank.out
rm log*

#extract zrank output pdb for dockq
create.pl zdockzrank.out 2000

#run dockq on above