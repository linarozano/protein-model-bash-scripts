#!/bin/bash
#Lrlrlr 040222 
#To unzip Swissmodel folders and compile pdb into one folder, renaming accordingly if required and sort scores into table using cat.

#using unar tool

for i in *.zip
do 
	unar -d "$i"
done

#process models, even consider several templates. preferably the 1st model since they have the highest score.
mkdir modelPDBs

for i in *
do
	if [ -d ${d} ]	#only run if it is a directory
	then
		cp "$i"/swissmodel/"$i"/models/01/model.pdb "$i"/swissmodel/"$i"/models/01/"$i"_model.pdb
		cp "$i"/swissmodel/"$i"/models/01/*_model.pdb modelPDBs
	fi
done

#process template lists
mkdir templates
for i in *
do
	if [ -d ${d} ]	#only run if it is a directory
	then
		cp "$i"/swissmodel/"$i"/templates.txt "$i"/swissmodel/"$i"/"$i"_templates.txt
		cp "$i"/swissmodel/"$i"/*templates.txt templates
	fi
done

#analyse templates cat into 1 table
#remove all from line 15 and before

cd templates
for i in *.txt
do
	sed -i '1,15d' "$i"
done
#cat *txt > all_template.txt
more *.txt > all_template.txt