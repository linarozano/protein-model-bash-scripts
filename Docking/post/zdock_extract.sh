#!/usr/bin/bash
#Lrlrlr 230321 zdock_extract.sh
#script to extract pdb files from ZDockResults.out and post process it
#postProcess ZDOCK output from Discovery Studio

#1) Rename ZDockResults.out and copy into one folder each
#can copy the whole thing and delete everything except ZDockResults.out, then rename the folders
 cp -r *blind/ zdock_blind
 
#rename folders retain only the last 2 name after _
echo "abc_asdfjhdsf_dfksfj_12345678.csv" | awk -F'[_.]' '{print $4}'
file=abc_asdfjhdsf_dfksfj_12345678.csv
n=${file%.*}   # n becomes abc_asdfjhdsf_dfksfj_12345678
n=${file##*_}  # n becomes 12345678.csv

folder= DockProteins*_blind
n=${folder%ind*}
n=${file#####*_}

#actually i dont have to rename it.

#2) copy receptor and ligand in input folder into output folder
ls -d Dock*
rename -v Dock Dock00 Dock?
ls -d Dock*
rename "_2021*_blind" "#####_blind"


#bash parameter expansion
for i in *; do  mv -v "$i" "${i//DockProteinsZDOCK_2021/}"; done	#remove anything before DockProteinsZDOCK

for i in *; do  mv -v "$i" "${i#*21_}"; done	#remove anything before 21_

#3) rename receptor and ligand name 
cd *_blind/Input
cp *b*dsv RECEPTOR_FILE
cp *c*dsv LIGAND_FILE
mv *FILE ../

#4) the output file
cd *_blind/Output
cp *out ../

###compile the commands to for loop

for f in *
do	
	cd *_blind/Input
	cp *dsv ../
	cd ../Output
	cp *out ../
	cd ../
	rm -r Input Output
done

for f in *; do cd *_blind/Input/ | cp *dsv ../ | cd ../Output/ | cp *out ../ | cd .. ; done


for f in *; do cd *_blind/ | cp Input/*dsv . | cp Output/*out . | cd .. ; done


for /d %F in ("G:\Deletable\*") do rename "%F" "%~nF_zzz"
for /d %F in *; do rename "%F" "%~nF_zzz" ; done

#delete subfolders with name
find . -type d -name Input -prune -exec rm -rf {} \;
find . -type d -name Output -prune -exec rm -rf {} \;



