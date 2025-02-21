#!bin/bash
#Lrlrlr restraint.sh 051220 edited 230221 custom for ClusPro amended 090921 for cutoff 5A.
#Script to make a list of active residues to be used for molecular docking between 2 protein chains.
#Input file will be output from pymol list_contacts

#GENERAL LIST: can be used for HADDOCK
sed -i -e "1d" *.txt #remove header (optional)
cat *.txt | sed 's!/! !g'| sed 's!`! !g' > main #split everything into columns

##EXTRA##
#filter only below 4.0 (column 9)
#cat mainA | awk '$9<5.00" > main		#print only if below 5.0

#A list of residues number for each chain (General)
cat main | awk '{print $3 ","}' | sort -u > temp1a	#capture chain1 name, remove duplicates
cat main | awk '{print $7 ","}' | sort -u > temp2a
#transpose list with whitespace
mapfile -t < temp1a; printf '%s' "${MAPFILE[@]}" $'\n' > ResNumber_chainI
mapfile -t < temp2a; printf '%s' "${MAPFILE[@]}" $'\n' > ResNumber_chainII
sed -i 's/.$//' ResNumber_chainI #remove last character
sed -i 's/.$//' ResNumber_chainII

##Extra add on 230212
#Custom for ClusPro attraction and repulsion residues input format (c-23, chainname-residuenumber)
#create chain1 data
cat main | awk '{print tolower ($1) "-" $3 " "}' | sort -u > temp1	#capture chain1 name, remove duplicates
cat main | awk '{print tolower ($5) "-" $7 " "}' | sort -u > temp2	#capture chain1 name

#transpose list with whitespace
mapfile -t < temp1; printf '%s' "${MAPFILE[@]}" $'\n' > ClusPro_chainI
mapfile -t < temp2; printf '%s' "${MAPFILE[@]}" $'\n' > ClusPro_chainII

#output files
tail -n +1  ResNumber_chainI ClusPro_chainI ResNumber_chainII ClusPro_chainII > residues5

rm temp* ClusPro* ResNum* main






