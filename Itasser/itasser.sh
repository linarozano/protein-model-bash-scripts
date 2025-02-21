#!/bin/bash
#Lrlrlr itasser.sh 290719
#To run itasser on multiple fasta sequences without template alignment mode.


ssh lrozano@10.128.0.13
lina1985

cd /home/lrozano/Documents/I-TASSER5.1/I-TASSERmod

sudo ./runI-TASSER.pl -libdir /home/lrozano/Documents/ITLIB/libdir -seqname *test* -datadir /home/lrozano/Desktop/ITASSER_runs/test/seq.fasta -runstyle gnuparallel 

#analyse output
cd /home/lrozano/Documents/I-TASSER5.1/file2html #location of the script

sudo /home/lrozano/Documents/I-TASSER5.1/file2html/file2html.py /home/lrozano/Desktop/ITASSER_runs/toxa/ #will generate index.html and result.tar.bz2



#start 416pm
#other parameters
-GO true -EC true -LBS true #predict gene ontology, EC number, ligand binding site

-pkgdir     means the path of the I-TASSER package. default is to
                  guess by the location of runI-TASSER.pl script
      -java_home  means the path contains the java executable "bin/java"
                  (your system needs to have Java installed)
      -runstyle   default value is "serial" which means running I-TASSER
                  simulation sequentially.
                  "parallel" means running parallel simulation jobs in the
                  cluster using PBS/torque job scheduling system.
                  "gnuparallel" means running parallel simulation jobs on
                  one computer with multiple cores using GNU parallel
      -homoflag   [real, benchmark],"real" will use all templates, "benchmark"
                  will exclude homologous templates    
      -idcut      sequence identity cutoff for "benchmark" runs, default
                  value is 0.3, range is in [0,1]    
      -ntemp      number of top templates output for each threading program,
                  default is 20, range is in [1,50]    
      -nmodel     number of final models output by I-TASSER, default value
                  is 5, range is in [1,10]
      -LBS        [false or true], whether to predict ligand-binding site, default is false
      -EC         [false or true], whether to predict EC number, default is false
      -GO         [false or true], whether to predict GO terms, default is false
      -restraint1 specify distance/contact restraints (read more at 
                  http://zhanglab.ccmb.med.umich.edu/I-TASSER/option1.html )
      -restraint2 specify template with alignment (read more at 
                  http://zhanglab.ccmb.med.umich.edu/I-TASSER/option4.html )
      -restraint3 specify template name without alignment (read more at 
                  http://zhanglab.ccmb.med.umich.edu/I-TASSER/option2.html )
      -restraint4 specify template file without alignment (read more at 
                  http://zhanglab.ccmb.med.umich.edu/I-TASSER/option3.html )
      -temp_excl  exclude specific templates from template library (read more 
                  at http://zhanglab.ccmb.med.umich.edu/I-TASSER/option6.html )
      -traj       this option means to deposit the trajectory files
      -light      this option means to run I-TASSER in fast mode (each 
                  simulation runs by default 5 hours maximum)
      -hours      specify maximum hours of simulations (default=5 when -light=true)
      -outdir     where the final results should be saved (default value is set to data_dir)