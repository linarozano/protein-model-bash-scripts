#!/bin/bash
#Lrlrlr itasser.sh 290719
#To run itasser on multiple fasta sequences without template alignment mode.

cd /home/lrozano/Documents/I-TASSER5.1/I-TASSERmod

sudo ./runI-TASSER.pl -libdir /home/lrozano/Documents/ITLIB/libdir -seqname test -datadir /home/lrozano/Desktop/ITASSER_runs/test/seq.fasta -runstyle gnuparallel 

for d in ./Sequences
do
	cd "$d"
	sudo /home/lrozano/Documents/I-TASSER5.1/I-TASSERmod/runI-TASSER.pl -libdir /home/lrozano/Documents/ITLIB/libdir -seqname toxa -datadir /home/lrozano/Desktop/I-TASSER_runs/7toxa_6max_apps19/toxa/seq.fasta -runstyle gnuparallel 
done

#to include in alignment as restraint2- specify template with alignment

Specify template with alignment: This option allows you (usually advanced users) to specify both template structure and the target-template alignment. You can use either 3D Format or FASTA Format.
The 3D Format is similar as the standard PDB format but two more columns are added from the template sequences, e.g.

ATOM   2001  CA  MET     1      41.116 -30.727   6.866  129 THR
ATOM   2002  CA  ALA     2      39.261 -27.408   6.496  130 ARG
ATOM   2003  CA  ALA     3      35.665 -27.370   7.726  131 THR
ATOM   2004  CA  ARG     4      32.662 -25.111   7.172  132 ARG
ATOM   2005  CA  GLY     5      29.121 -25.194   8.602  133 ARG

Column 1 -30: Atom & Residue records of query sequence.
Column 31-54: Coordinates of atoms in query copied from corresponding atoms in template.
Column 55-59: Corresponding residue number in template based on alignment
Column 60-64: Corresponding residue name in template
The FASTA Format is similar as the standard FASTA format except that the 3D structure is attached after the sequence alignemnts. e.g.
>TARGET
--------------------------------------------------------------------------
------------------------------------------------------MAARGRRAEPQGREAPGPAG
GGGGGSRWAESGSGTSPESGDEEVSGAGSSPVSGGVNLFANDGSFLELFKRKMEEEQRQRQEEPPPGPQRPDQS
AAAAGPGDPKRKGGPGSTLS---------FVGKRRGGNKLALKTGIVAKKQKTEDEVL------------TSKG
DAWAKYMAEVKKYKAHQCGDDDKTRPLVK---------------------------------------------
--------------------------------------------------------------------------
>1w0r:A
DPVLCFTQYEESSGKCKGLLGGGVSVEDCCLNTAFAYQKRSGGLCQPCRSPRWSLWSTWAPCSVTCSEGSQLRY
RRCVGWNGQCSGKVAPGTLEWQLQACEDQQCCPEMGGWSGWGPWEPCSVTCSKGTRTRRRACNHPAPKCGGHCP
GQAQESEACDTQQVCPTHGAWATWGPWTPCSASCHGG--PHEPKETRSRKCSAPEPSQKPPGKPCPGLAYEQRR
CTGLPPCPVAGGWGPWGPVSPCPVTCGLGQTMEQRTCNHPVPQHGGPFCAGDATRTHICNTAVPCPVDGEWDSW
GEWSPCIRRNMKSISCQEIPGQQSRGRTCRGRKFDGHRCAGQQQDIRHCYSIQHCPLKGSWSEWSTWGLCMPPC
GPNPTRARQRLCTPLLPKYPPTVSMVEGQGEKNVTFWGRPLPRCEELQGQKLVVEEKRPCLHVPACKDPEEEEL

REMARK The following is the PDB file of 1w0r:A
ATOM      1  N   ASP     1     -61.352  10.686 -21.622
ATOM      2  CA  ASP     1     -61.577   9.382 -21.306
ATOM      3  C   ASP     1     -60.494   8.357 -21.572
ATOM      4  O   ASP     1     -59.461   8.661 -22.046
ATOM      5  CB  ASP     1     -62.869   9.947 -21.978
ATOM      6  CG  ASP     1     -64.050   9.936 -21.019
ATOM      7  OD1 ASP     1     -64.163   9.015 -20.186
ATOM      8  OD2 ASP     1     -64.907  10.837 -21.154
ATOM      9  N   PRO     2     -60.719   7.053 -21.256
...
ATOM   3368  OE2 GLU   441       3.538 -11.561 -19.634
ATOM   3369  N   LEU   442       5.760 -10.509 -22.452
ATOM   3370  CA  LEU   442       4.343 -10.088 -22.296
ATOM   3371  C   LEU   442       3.130 -10.010 -23.201
ATOM   3372  O   LEU   442       3.217  -9.645 -24.316
ATOM   3373  CB  LEU   442       2.901 -10.133 -22.751
ATOM   3374  CG  LEU   442       1.899  -9.162 -22.168
ATOM   3375  CD1 LEU   442       0.483  -9.471 -22.688
ATOM   3376  CD2 LEU   442       1.922  -9.267 -20.645
ATOM   3377  OXT LEU   442       2.654  -9.424 -25.326
END
Note:
(a) To avoid the possible error in reproducing template structure and alignments, rather than specifying PDB ID, the users who use FASTA format must attach the original PDB structure of the template in the FASTA file, see the example.
(b) The query name specified in the FASTA alignment (in the above example as "TARGET") should be the same as the name specified in ID form on the submission page. If you leave the ID form blank, the description line of query in the FASTA alignment should be specified as ">your_protein".

#restraint3- specify template name only

Specify template without alignment: If you want I-TASSER to use a specific PDB structure as a template, you can use this option specify the PDB structure. You only need to type in the PDBID:ChainID, e.g. 1wor:A without specifying the target-template alignments.If the chain information is not present in the PDB file, indicate the ChainID using "_".I-TASSER will first fetch the structure from the PDB library and then generate the target-template alignment based on our in-house alignment tool, MUSTER.
1zld:A

#restraint4- specify template file without alignment
Specify template without alignment: You can actually use any 3D structure as the template, which does not necessary exist in the PDB library. In this case, you can use this option to upload the 3D structure. This structure file must be in the standard PDB format. You do not need to input the target-template alignments. I-TASSER will generate target-template alignment based on our in-house alignment tool, MUSTER.
REMARK The following is the PDB file of 1w0r:A
ATOM      1  N   ASP     1     -61.352  10.686 -21.622
ATOM      2  CA  ASP     1     -61.577   9.382 -21.306
ATOM      3  C   ASP     1     -60.494   8.357 -21.572
ATOM      4  O   ASP     1     -59.461   8.661 -22.046
ATOM      5  CB  ASP     1     -62.869   9.947 -21.978
ATOM      6  CG  ASP     1     -64.050   9.936 -21.019
ATOM      7  OD1 ASP     1     -64.163   9.015 -20.186
ATOM      8  OD2 ASP     1     -64.907  10.837 -21.154

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
	  
	  #analyse output
cd /home/lrozano/Documents/I-TASSER5.1/file2html #location of the script

./file2html.py /home/lrozano/Desktop/ITASSER_runs/test/ #will generate index.html and result.tar.bz2
sudo /home/lrozano/Documents/I-TASSER5.1/file2html/file2html.py /home/lrozano/Desktop/I-TASSER_runs/7toxa_6max_apps19/toxa/ #will generate index.html and result.tar.bz2