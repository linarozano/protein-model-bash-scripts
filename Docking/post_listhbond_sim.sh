#!usr/bin/bash
#Lrlrlr 260121edited110221 post_listhbond.sh
#script to summarize the list of hbonds between 2 chains
#list_hbond plugin will list all hydrogen bonds: inter & intrachain hbonds

#PRE-PROCESS:reformating of the output data before further processing.
#seperate data into columns containing '/' and space into delimited table.
#assume there is no header line containing command- starts from A/...

#!usr/bin/bash
cat output_listhbond.txt | sed 's!/! !g' > listhbond #replace slash with space
sed -i -n '/ / p' listhbond	#remove empty lines permanently

f0="listhbond"

#STEP1= Differentiate inter and intrachain hydrogen bonds

#1) Identify hbond from similar chains (INTRA): what to know about similar chain?
#--number of H-bonds,--conclude what residues how many H-bonds each.
#each will be treated as independent column. process using awk.
#chainA= column $1, chain2=column $5

awk '$1==$5 {print $0}' "$f0" > Intrachain_Hbonds	#print only if the first letter in column 1 equals to the first letter in column 5
f1="Intrachain_Hbonds"	#using variable
wc -l "$f1" > temp1a	#print out line number for certain file with filename next to it; equals to #of hbonds
f1a="temp1a"

cat "$f1a" "$f1" > INTRAchain.txt	#combine into final output
f1b="INTRAchain.txt"

echo "<<<<<<<<<<SUMMARY>>>>>>>>>>" >> "$f1b"
#how many in chain a and how many in chain b
#WARNING produce error if there is no chainA #SOLUTION edit chain in the script below 'A' and 'B'
echo "H-bonds in the first chain = $(grep -c '^A' "$f1")" >> "$f1b"	#echo output of grep append to end of file#will do the same for all

#number of residues involved = 
echo "Number of unique residues = $(cat "$f1" | awk '$1=="A" {print $2}' | awk '!a[$0]++' | wc -l) <$(cat "$f1" | awk '$1=="A" {print $2}' | awk '!a[$0]++' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$f1b"	#list unique residues

echo "Number of residues with multiple H-bonds in one sidechain = $(cat "$f1" | awk '$1=="A" {print $2}' | uniq -d | wc -l) <$(cat "$f1" | awk '$1=="A" {print $2}' | uniq -d | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$f1b"	#list residues with multiple Hbonds

#second chain
echo "H-bonds in the second chain = $(grep -c '^B' "$f1")" >> "$f1b"
echo "Number of unique residues = $(cat "$f1" | awk '$1!="A" {print $2}' | awk '!a[$0]++' | wc -l) <$(cat "$f1" | awk '$1!="A" {print $2}' | awk '!a[$0]++' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$f1b"
echo "Number of residues with multiple H-bonds in one sidechain = $(cat "$f1" | awk '$1!="A" {print $2}' | uniq -d | wc -l) <$(cat "$f1" | awk '$1!="A" {print $2}' | uniq -d | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$f1b"
echo "<<<<<<<<<<ENDOFSUMMARY>>>>>>>>>>" >> "$f1b"
##KIV##addon

#2) Identify hbond from 2 different chains (INTER)

awk '$1!=$5 {print $0}' "$f0" > Interchain_Hbonds	#does not equal to
f2="Interchain_Hbonds"	
wc -l "$f2" > temp1b
f2a="temp1b"
cat "$f2a" "$f2" > INTERchain.txt
f2b="INTERchain.txt"

echo "<<<<<<<<<<SUMMARY>>>>>>>>>>" >> "$f2b"
#number of residues involved = 
echo "Number of unique residues = $(cat "$f2" | awk '{print $2}' | awk '!a[$0]++' | wc -l) <$(cat "$f2" | awk '{print $2}' | awk '!a[$0]++' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$f2b"	#list unique residues

echo "Number of residues with multiple H-bonds in one sidechain = $(cat "$f2" | awk '{print $2}' | uniq -d | wc -l) <$(cat "$f2" | awk '{print $2}' | uniq -d | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$f2b"	#list residues with multiple Hbonds
echo "<<<<<<<<<<ENDOFSUMMARY>>>>>>>>>>" >> "$f2b"
#rm *_H* temp*	#cleanup

