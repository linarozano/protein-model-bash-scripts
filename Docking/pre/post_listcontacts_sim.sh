#!usr/bin/bash
#Lrlrlr 260121edited120221 post_listcontacts.sh
#script to simplify the list of contacts between 2 chains
#for list contacts all will be equally seperated chains

#PRE-PROCESS:reformating of the output data before further processing.
#seperate data into columns containing '/' and space into delimited table.
#assume there is no header line containing command- starts from A/...
#filename must contain *_listcontacts.txt

sed -i -e "1d" *_listcontacts.txt #remove 1st line header (optional)

#!usr/bin/bash
cat *_listcontacts.txt | sed 's!/! !g' > listcontacts #replace slash with space
sed -i -n '/ / p' listcontacts	#remove empty lines permanently

c0="listcontacts"

#overall contacts
echo "Number of all contacts = $(cat "$c0" | wc -l)" > Contacts_summary.txt

c1="Contacts_summary.txt"

#number of unique residues in chain1. repeat for chain2
#number of residues involved = 
echo "Number of unique residues in chain1 = $(cat "$c0" | awk '{print $2}' | awk '!a[$0]++' | wc -l) <$(cat "$c0" | awk '{print $2}' | awk '!a[$0]++' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$c1"	#list unique residues in chain1

echo "Number of unique residues in chain2 = $(cat "$c0" | awk '{print $5}' | awk '!a[$0]++' | wc -l) <$(cat "$c0" | awk '{print $5}' | awk '!a[$0]++' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$c1"	#list unique residues in chain2

#Type of residues unique in chain1. repeat for chain2
#split column 2 seperating residue with #.and process only residues name.
cat "$c0" | sed 's!`! !g' > temp1

#CHAIN1
echo "<<<<<<<<<<CHAIN I>>>>>>>>>>" >> "$c1"
echo "Type of residues unique in chain1 = $(cat temp1 | awk '{print $2}' | awk '!a[$0]++' | wc -l) <$(cat temp1 | awk '{print $2}' | awk '!a[$0]++' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$c1"	#list unique residues in chain1
#Stats of each type of residues
echo "Polar residues = $(cat temp1 | awk '{print $2}' | awk '!a[$0]++' | egrep -c 'SER|THR|TYR|ASN|GLN') <$(cat temp1 | awk '{print $2}' | awk '!a[$0]++' | egrep -w 'SER|THR|TYR|ASN|GLN' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$c1"	#list polar residues
echo "Positive charged residues = $(cat temp1 | awk '{print $2}' | awk '!a[$0]++' | egrep -c 'LYS|ARG|HIS') <$(cat temp1 | awk '{print $2}' | awk '!a[$0]++' | egrep -w 'LYS|ARG|HIS' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$c1"	#list +ve charge
echo "Negative charged residues = $(cat temp1 | awk '{print $2}' | awk '!a[$0]++' | egrep -c 'ASP|GLU') <$(cat temp1 | awk '{print $2}' | awk '!a[$0]++' | egrep -w 'ASP|GLU' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$c1"	#list -ve residues
echo "Non-polar residues = $(cat temp1 | awk '{print $2}' | awk '!a[$0]++' | egrep -c 'GLY|ALA|VAL|CYS|PRO|LEU|ILE|MET|TRP|PHE') <$(cat temp1 | awk '{print $2}' | awk '!a[$0]++' | egrep -w 'GLY|ALA|VAL|CYS|PRO|LEU|ILE|MET|TRP|PHE' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$c1"	#list nonpolar residues

#CHAIN2
echo "<<<<<<<<<<CHAIN II>>>>>>>>>>" >> "$c1"
echo "Type of residues unique in chain2 = $(cat temp1 | awk '{print $6}' | awk '!a[$0]++' | wc -l) <$(cat temp1 | awk '{print $6}' | awk '!a[$0]++' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$c1"	#list unique residues in chain1
#Stats of each type of residues
echo "Polar residues = $(cat temp1 | awk '{print $6}' | awk '!a[$0]++' | egrep -c 'SER|THR|TYR|ASN|GLN') <$(cat temp1 | awk '{print $6}' | awk '!a[$0]++' | egrep -w 'SER|THR|TYR|ASN|GLN' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$c1"	#list polar residues
echo "Positive charged residues = $(cat temp1 | awk '{print $6}' | awk '!a[$0]++' | egrep -c 'LYS|ARG|HIS') <$(cat temp1 | awk '{print $6}' | awk '!a[$0]++' | egrep -w 'LYS|ARG|HIS' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$c1"	#list +ve charge
echo "Negative charged residues = $(cat temp1 | awk '{print $6}' | awk '!a[$0]++' | egrep -c 'ASP|GLU') <$(cat temp1 | awk '{print $6}' | awk '!a[$0]++' | egrep -w 'ASP|GLU' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$c1"	#list -ve residues
echo "Non-polar residues = $(cat temp1 | awk '{print $6}' | awk '!a[$0]++' | egrep -c 'GLY|ALA|VAL|CYS|PRO|LEU|ILE|MET|TRP|PHE') <$(cat temp1 | awk '{print $6}' | awk '!a[$0]++' | egrep -w 'GLY|ALA|VAL|CYS|PRO|LEU|ILE|MET|TRP|PHE' | awk '{s=s==""?$0:s","$0}END{print s}')>" >> "$c1"	#list nonpolar residues
echo "<<<<<<<<<<THEEND>>>>>>>>>>" >> "$c1"
echo "~LRLR2021~" >> "$c1"


#rm *_H* temp*	#cleanup








