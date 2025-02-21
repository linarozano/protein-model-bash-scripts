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
rm *_H* temp*	#cleanup

####END###


##NOTES##

#solving the issue of depending on chain letters. place column values into arrays.

chains=( $(cut -d ' ' -f1 Intrachain_Hbonds ) )	#all entry in the arrays
#want unique value of array only

chain=( $(cat Intrachain_Hbonds | awk '{print $1}' | awk '!a[$0]++' ) )
printf "%s\n" "${chain[0]}"
c1="${chain[0]}"

echo "Number of unique residues = $(cat Intrachain_Hbonds | awk '$1=="$c1" {print $1}' | awk '!a[$0]++' | wc -l) <$(cat "$f1" | awk '$1=="A" {print $2}' | awk '!a[$0]++' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$f1b"


awk '{Ch[$1]++;} END {for (var in Ch) print "H-bonds in chain", var, "=", Ch[var]}' Intrachain_Hbonds
awk '{Ch[$1]++;} END {for (var in Ch) print "H-bonds in chain", var, "=", Ch[var]}' Intrachain_Hbonds >> "$f1b"	#count the number of hbonds in chain1&2

cat res.awk 
BEGIN {
print "IP Address\tAccess Count\tNumber of sites";
}
{
Ch[$1]++;
count[$1]+=$2;
}
END{
for (var in Ch)
	print var,"\t",Ch[var],"\t\t",count[var];
}
awk -f res.awk Intrachain_Hbonds



#a) Number of unique residues involved with h-bonding
#find duplicates in column2. repeat find duplicates in column6
awk '!a[$2]++' temp1	#retain single residues in column2/remove duplicates


#count the number of similar residue found within column2/repeat the same for column6;for one residue how many h-bonds.
awk 'cnt[$2]++{if (cnt[$2]==2) print prev[$2]; print} {prev[$2]=$0}' "$f2"	#the starter
echo "H-bonds in the second chain = $(grep -c '^B' "$f2")" >> Intrachain.txt


	#print only residue name in column 2, and include number count
awk '!a[$2]++' temp1	#retain single residues in column2/remove duplicates
awk 'cnt[$6]++{if (cnt[$6]==2) print prev[$6]; print} {prev[$6]=$0}' temp1	#the partner
awk '!a[$6]++' temp1	#retain single residues in column2/remove duplicates

#hbonds in similar residues
#retain unique residues containing no duplicates at all
#awk '{a[$2]++;b[$2]=$0}END{for(x in a)if(a[x]==1)print b[x]}' temp1

#count list in the line
#echo number of H-bonds = *


#how many h-bonds in each residue pairs


myuser="$(grep '^vivek' /etc/passwd)"
echo "$myuser"



a="a b c"
echo "the middle is $(echo $a | awk '{print $2}')"

line="This is where we select from a table."
echo "$line" | grep -c 'select'	#will output as 1

##extras##
#cat temp1  | awk '{ print $1 " :  " $5 }' #print only column 1 and 5 including delimiter in between
#awk -F\| '$3 > 0 { print substr($3,1,6)}' file1	#print only if column 3 is more than 0
#awk '{ print substr($1,1,6)}' output_listhbond.txt	#print the first six letters in a column
#awk '{ print substr($1,1,1)}' output_listhbond.txt  #print the first letter in a column
#cat FileB | awk '{ if ($1!='$i') print $0_}'>> Result
#cat -b temp1	#display line numbers- don't really need this
#awk 'END {print NR}' temp1 #count list in the line; number of H-bonds INTRAchain
##extras##