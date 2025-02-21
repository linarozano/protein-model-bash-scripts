#!bin/bash
#Lrlrlr restraint.sh 051220 edited 230221 edited 240321 custom forloop

for x in ./*.txt
do
	cat $x | sed 's!/! !g'| sed 's!`! !g' > mainA #split everything into columns
	cat mainA | awk '$9<4.00' > main		#print only if below than 4.0
	cat main | awk '{print $3 ","}' | sort -u > temp1a	#capture chain1 name, remove duplicates
	cat main | awk '{print $7 ","}' | sort -u > temp2a
	mapfile -t < temp1a; printf '%s' "${MAPFILE[@]}" $'\n' > ResNumber_chainI
	mapfile -t < temp2a; printf '%s' "${MAPFILE[@]}" $'\n' > ResNumber_chainII
	sed -i 's/.$//' ResNumber_chainI #remove last character
	sed -i 's/.$//' ResNumber_chainII
	cat main | awk '{print tolower ($1) "-" $3 " "}' | sort -u > temp1	#capture chain1 name, remove duplicates
	cat main | awk '{print tolower ($5) "-" $7 " "}' | sort -u > temp2	#capture chain1 name
	mapfile -t < temp1; printf '%s' "${MAPFILE[@]}" $'\n' > ClusPro_chainI
	mapfile -t < temp2; printf '%s' "${MAPFILE[@]}" $'\n' > ClusPro_chainII
	tail -n +1  ResNumber_chainI ClusPro_chainI ResNumber_chainII ClusPro_chainII > $x.residues
	rm temp* ClusPro* ResNum* mainA main
done

