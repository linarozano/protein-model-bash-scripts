#!/usr/bin/bash
#Lrlrlr 260421 ccharppi.sh
#commands to post process zdock extracted complexes for ccharppi.

#copy top150 into folder
#mkdir top150
#cp complex.{1..150}.pdb top150/

#seperate complex into ligand and receptor
#use END in the middle as seperator. can also remove END, not needed.
#split file at END. END only occurs once, so can use this.


for x in ./*.pdb 
do 
	csplit "$x" '/^END$/' '{*}'
	sed -i '/TER/d' xx00
	sed -i '/END/d' xx01
	mv xx00 $x.rec.pdb
	mv xx01 $x.lig.pdb
done

rename s/pdb\.// *.pdb

ls -d *rec* > log1
ls -d *lig* > log2

paste log1 log2 | column -s $'\t' -t > jobs.csv
#can include chain in jobs.csv
#p2
mkdir cchar_post
mv *rec* *lig* jobs.csv cchar_post
rm log*

cd cchar_post
mkdir data1_800
mkdir data2_800
mkdir data3_400
cp complex.{1..800}.rec.pdb data1_800/
cp complex.{1..800}.lig.pdb data1_800/
cp complex.{801..1600}.rec.pdb data2_800/
cp complex.{801..1600}.lig.pdb data2_800/
cp complex.{1601..2000}.rec.pdb data3_400/
cp complex.{1601..2000}.lig.pdb data3_400/

#p3- create job.csv but have to edit in excel to include chain identifier.
ls -d *rec* > log1
ls -d *lig* > log2
paste log1 log2 | column -s $'\t' -t > job.csv
rm log*

##Extras1: for 150 analysis
for f in ./*_cc
do 
	cd "$f"
	for x in ./*.pdb 
	do 
		csplit "$x" '/^END$/' '{*}'
		sed -i '/TER/d' xx00
		sed -i '/END/d' xx01
		mv xx00 $x.rec.pdb
		mv xx01 $x.lig.pdb
	done
	rename s/pdb\.// *.pdb
	ls -d *rec* > log1
	ls -d *lig* > log2
	paste log1 log2 | column -s $'\t' -t > jobs.csv
	mkdir $f.cchar
	mv *rec* *lig* jobs.csv $f.cchar
	mv $f.cchar ../cchar_compiled
	rm log*
	cd ..
done

##Extras2: 050521 include chain identifier in script so do not have to import to excel
#need to open complex*pdb to identify chain for rec and lig.
#process receptor file
ls -d *rec* > log1
ls -d *lig* > log2
#cat complex.1.rec.pdb | sed '/REMARK/d' | sed '/CRYST1/d' | sed '/HETATM/d' > log1	#remove REMARK, CRYST1 line
sed -n 10p complex.1.rec.pdb > log3	#capture column number 5 to identify chain number. maybe just keep the 1st line first or maybe just line number 10, so i can omit the previus command
cat log3 | awk '{print $5}' > log4
for i in {1..150}; do cat log4 >> log5; done #CUSTOM: by default replicate content in log3 150 times
#process ligand file
sed -n 10p complex.1.lig.pdb > log3a	
cat log3a | awk '{print $5}' > log4a
for i in {1..150}; do cat log4a >> log5a; done
paste -d':' log1 log5 log2 log5a > job.csv	#use semicolon as seperator, combine with log1 and log2

#the script for 150
mkdir compressed
for f in ./*ccharppi 
do 
	cd "$f"
	rm log* *csv
	ls -d *rec* > log1
	ls -d *lig* > log2
	sed -n 10p complex.1.rec.pdb > log3	
	cat log3 | awk '{print $5}' > log4
	for i in {1..150}; do cat log4 >> log5; done 
	sed -n 10p complex.1.lig.pdb > log3a	
	cat log3a | awk '{print $5}' > log4a
	for i in {1..150}; do cat log4a >> log5a; done
	paste -d':' log1 log5 log2 log5a > job.csv
	tar czf $f.tgz *pdb job.csv
	mv *tgz ../compressed
	cd ..
done
