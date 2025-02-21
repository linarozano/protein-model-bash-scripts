#!/usr/bin/bash
#Lrlrlr 260421 ccharppi.sh edited 110621
#commands to post process zdock extracted complexes for ccharppi for top150
#also will remove other lines not ATOM

#copy top150 into folder
#mkdir top150
#cp complex.{1..150}.pdb top150/

#seperate complex into ligand and receptor
#use END in the middle as seperator. can also remove END, not needed.
#split file at END. END only occurs once, so can use this.

##Extras1: for 150 analysis adopted from ccharppi.sh

for x in ./*.pdb 
do 
	sed -i '/REMARK/d;/CRYST1/d;/HETATM/d' "$x"
	csplit "$x" '/^END$/' '{*}'
	sed -i '/TER/d' xx00
	sed -i '/END/d' xx01
	mv xx00 $x.rec.pdb
	mv xx01 $x.lig.pdb
done
#rename s/pdb\.// *.pdb #have to install rename function
ls -d *rec* > log1
ls -d *lig* > log2
sed -n 10p complex.1.pdb.rec.pdb > log3	
cat log3 | awk '{print $5}' > log4
for i in {1..200}; do cat log4 >> log5; done  #edit max number
sed -n 10p complex.1.pdb.lig.pdb > log3a	
cat log3a | awk '{print $5}' > log4a
for i in {1..200}; do cat log4a >> log5a; done	#edit max number
paste -d':' log1 log5 log2 log5a > job.csv
tar czf ccharppi.tgz *pdb job.csv
mkdir ccharppi_processed 
mv job.csv log* *pdb.lig.pdb *pdb.rec.pdb ccharppi_processed






