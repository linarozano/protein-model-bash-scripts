#!/bin/bash
#Lrlrlr itas_nim.sh
#To run itasser on Nimbus hmodel instance. 
#multiple fasta sequences without template alignment mode.

for d in ./Sequences
do
	cd "$d"
	sudo /home/lrozano/Documents/I-TASSER5.1/I-TASSERmod/runI-TASSER.pl -libdir /home/lrozano/Documents/ITLIB/libdir -seqname toxa -datadir /home/lrozano/Desktop/I-TASSER_runs/7toxa_6max_apps19/toxa/seq.fasta -runstyle gnuparallel 
done


/home/ubuntu/I-TASSER5.1/I-TASSERmod/runI-TASSER.pl -pkgdir /home/ubuntu/I-TASSER5.1 -libdir /home/ubuntu/ITLIB -LBS true -EC true -GO true -seqname example -datadir /home/ubuntu/I-TASSER5.1/example -java_home /usr -light true -hours 6 -outdir /home/ubuntu/I-TASSER5.1/example

#have to rename fasta sequences to seq.fasta.
#submitted test run.

for d in ./toxalike_itasser
do
	cd "$d"
	sudo /home/ubuntu/I-TASSER5.1/I-TASSERmod/runI-TASSER.pl -pkgdir /home/ubuntu/I-TASSER5.1 -libdir /home/ubuntu/ITLIB -seqname toxalike_itasser -datadir /home/ubuntu/toxalike_itasser/toxA_DJ38_filter.fasta -outdir /home/ubuntu/toxalike_itasser -runstyle gnuparallel
done

sudo /home/ubuntu/I-TASSER5.1/I-TASSERmod/runI-TASSER.pl -pkgdir /home/ubuntu/I-TASSER5.1 -libdir /home/ubuntu/ITLIB -seqname toxalike_itasser -datadir /home/ubuntu/toxalike_itasser/seq.fasta -outdir /home/ubuntu/toxalike_itasser -runstyle gnuparallel