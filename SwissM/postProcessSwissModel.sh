#!/bin/bash
#Lrlrlr 020422 capture_sequences.sh
#to extract the sequence of target from report.html of SwissModel output.

#Folder navigation.

for d in *
do
	if [ -d ${d} ]	#only run if it is a directory
	then
		mkdir sequences
		cd "$d"/swissmodel/"$d"/
		grep "<pre>Target" report.html > $d.sequence
		cp $d.sequence ../../../sequences
		cd ../../../
	fi
done

cd sequences
tail -n +1 *sequence > all_seq.txt

#find in report.html line containing target sequence. and match with folder number. example 0_10 LSATSAY

