#!/usr/bin/bash
#Lrlrlr 100922 ccharppiprepbulk.sh
#commands to prepare directories of top200 extracted complexes for ccharppi webserver submission.
#will be used in combination with ccharppi_top150.sh

for x in ./*_top200 
do 
	cp ccharppi_top150.sh "$x"
	cd "$x"
	dos2unix *
	bash ccharppi_top150.sh
	cd ..
done