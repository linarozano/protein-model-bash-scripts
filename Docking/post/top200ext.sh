#!/usr/bin/bash
#Lrlrlr 100922 top200.sh
#commands to extract complexes from tar files in bulk.

for x in ./*.tar.gz 
do 
	tar -zxvf "$x" --files-from *.txt
	mv 54k_zdock "$x"_top200
done