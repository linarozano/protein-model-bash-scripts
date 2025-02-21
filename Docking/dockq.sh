#!/bin/bash
#Lrlrlr dockq.sh 051220 
#Script to run DockQ analysis on multiple PDB files
#Run in directory containing seperate PDB files with DockQ installed and set in PATH.
#DOckQ installed on Nimbus mdocking lros

#Reference PDB file in the same folder named as native.pdb
#pdbfetch 6fud
#mv 6fud.pdb native.pdb

#Run DockQ

for x in ./*.pdb 
do 
	DockQ.py "$x" native.pdb > $x.dockqlog
done
cat *.dockqlog > dockq.log
rm *.dockqlog

#p2
cp dockq.log dockqORI
cat dockq.log | grep -o -P '(?<=./).*(?=.pdb)' > log0		#capture only id value 
cat dockq.log | grep -o -P '(?<=Fnat).*(?=contacts)' > log1		
cat dockq.log | grep -o -P '(?<=Fnonnat).*(?=contacts)' > log2		
sed -i '/(iRMS)/d' dockq.log #remove line containing (iRMS)
grep "iRMS" dockq.log > log3		
grep "LRMS" dockq.log > log4	
awk '/LRMS/ {f=NR} f && NR==f+1' dockq.log > log5  #get line after LRMS
grep "DockQ_CAPRI" dockq.log > log6		
#grep "DockQ 0" dockq.log > log7	#assuming all will not have perfect 1.0 score	
awk '/DockQ_CAPRI/ {f=NR} f && NR==f+1' dockq.log > log7

paste log0 log1 log2 log3 log4 log5 log6 log7 | column -s $'\t' -t > dockq.csv	
rm log*