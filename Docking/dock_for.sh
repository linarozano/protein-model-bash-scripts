#!/usr/bin/bash
#Lrlrlr 240321 dockq_for.sh
#Running dockq on nimbus for multiple folders.

for f in ./*_blind
do
	cp create* dockq.sh "$f"
	cd "$f"
	create.pl ZDockResults.out 2000
	mkdir extracted_2k
	mv complex* extracted_2k/
	cp dockq.sh extracted_2k/
	cd ..
done

#for x in ./*_blind
#do
#	cd "$x"
#	cd extracted_2k/
#	bash dockq.sh
#	cd ../../
#done


	