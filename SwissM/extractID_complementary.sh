#!/bin/bash
#Lrlrlr 300322
#to extract Phyre2 output and compile IDs with real sequence name.

#Extract all .tar.gz folder

for i in *.tar.gz
do 
	tar -zxvf "$i"
done

#once in folder. extract related information from .jobs (task scheduler task object) file into new file 
mkdir JOBS

for d in *
do
	if [ -d ${d} ]	#only run if it is a directory
	then
		cd "$d"
		cp *.job ../JOBS
		cd ..
	fi
done

#retain sequence and description.
#save in mother directory and concatenate all files.DONE.

cd JOBS
cat *.job > compiledJobs
grep 'Sequence:\|Description:' compiledJobs > listofJobs