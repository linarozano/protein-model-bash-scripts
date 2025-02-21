#!bin/bash
#Lrlrlr restraint.sh 051220
#Script to make a list of restraints to be used for molecular docking between 2 protein chains.
#Can also be used for interaction analysis.
#Cutoff 4A and include all contacts- H-bonds or non bonds
#Input file will be output from pymol list_contacts

#remove the 1st line
#Analyse chain 1 (the one on the left)
cat *contacts*txt | awk '{print $1}' > c1
cat *contacts*txt | awk '{print $2}' > c2

cat c1 | grep -o -P '(?<=`).*(?=/)' > log1
cat c2 | grep -o -P '(?<=`).*(?=/)' > log2

#remove duplicates
sort -u log1 > chain1
sort -u log2 > chain2

tail -n +1  chain1 chain2 > restraints
rm log* chain* c1 c2

#echo '********************************' | cat ch1 - ch2