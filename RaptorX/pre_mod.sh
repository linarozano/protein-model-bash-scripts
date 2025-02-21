#!/bin/bash
#Lrlrlr 011119 pre_mod.sh
#Script to run pre-modelling steps for RaptorX 
#All tools are associated with RaptorX http://raptorx.uchicago.edu/download/bGluYS5yb3phbm9AcG9zdGdyYWQuY3VydGluLmVkdS5hdQ==/

#1. Secondary structure prediction using DeepCNF_SS
./DeepCNF_SS.sh -i 2mm0.fasta #took 14 minutes to complete

#Output= 2mm0.ss3 , 2mm0.ss8

#2. Disordered prediction using AUCpreD- DONE
#BuildFeature= generate sequence profile to later be used to predict disorder (format .TGT)

./buildFeature -i 2mm0.fasta -o 2mm0.tgt > run.log	 #input in fasta file and also output TGT,  10mins 1seq on 1cores.

./AUCpreD.sh -i example/2mm0.fasta -o 2mm0.diso_noprof #without sequence profile .TGT format, oneclick done.

./AUCpreD.sh -i example/2mm0.fasta -m 0 -c 8 -o 2mm0.diso_profile 
(or)
./AUCpreD.sh -i example/2mm0.tgt -o 2mm0.diso_profile #with sequence profile .TGT format, oneclick done.

#Output= 2mm0.tgt, run.log, 2mm0.diso_noprof, 2mm0.diso_profile

#3. Pre-Threading&Modelling- setting up databases
#REQUIRED DATABASES for CNFpred
#ALWAYS CHECK FOR LATEST UPDATE BEFORE USE (obtained from RaptorX downloads): 
#a) template and NR databases: (For threading)
#database/TPL_BC100/contains entry for TPL_BC40 and TPL_Remain #extras TemplateList
#database NR_new (will have new release of nr90 and nr70)
wget http://raptorx.uchicago.edu/download/bGluYS5yb3phbm9AcG9zdGdyYWQuY3VydGluLmVkdS5hdQ==/44/TPL_BC40_20191031.tar.gz
wget http://raptorx.uchicago.edu/download/bGluYS5yb3phbm9AcG9zdGdyYWQuY3VydGluLmVkdS5hdQ==/45/TPL_Remain_20191031.tar.gz
wget http://raptorx.uchicago.edu/download/bGluYS5yb3phbm9AcG9zdGdyYWQuY3VydGluLmVkdS5hdQ==/46/TemplateLists_20191031.tar.gz

tar -zxvf TPL_BC40_*.tar.gz	#.tpl format
tar -zxvf TPL_Remain_*.tar.gz #.tpl format
tar -zxvf TemplateLists_*.tar.gz #contents will start with bc**map and list

#b) PDB databases: (For modelling)
#database/pdb_BC100/contains entry for pdb_BC40 and pdb_Remain #extras TemplateList

wget http://raptorx.uchicago.edu/download/bGluYS5yb3phbm9AcG9zdGdyYWQuY3VydGluLmVkdS5hdQ==/52/pdb_BC40_20191031.tar.gz
wget http://raptorx.uchicago.edu/download/bGluYS5yb3phbm9AcG9zdGdyYWQuY3VydGluLmVkdS5hdQ==/53/pdb_Remain_20191031.tar.gz

tar -zxvf pdb_BC40_*.tar.gz
tar -zxvf pdb_Remain_*.tar.gz

#4. Threading
#can use .TGT format from the previous runs generated from buildFeature, if not have to generate in this step
./buildFeature -i 2mm0.fasta -c 4 -o 2mm0.tgt
#copy .tgt file into database/TGT folder
cp *.tgt TGT

#a) Start with CNFsearch= search similar template in a database for a query protein sequence
./CNFsearch -a NP -q query_name [-l template_list] [-d tpl_root] [-g tgt_root] [-o output_file] [-n topN] [-p pval]
#using mpi
mpirun -np NP ./CNFsearch_mpi -q query_name [-l template_list] [-d tpl_root] [-g tgt_root] [-o output_file] [-n topN] [-p pval]

./CNFsearch -a 1 -q 2mm0 > run.log #test using 1 core to estimate the time, takes 1 hour

./CNFsearch -a 4 -q same2mm0 > run4.log #test using 1 core to estimate the time, takes 15mins

#a) Pairwise alignment using CNFalign (there are 3 modes)
#CNFalign_lite is 5-6 times faster than CNFalign_fast, which in turn is 30% faster than CNFalign_normal.
#However, CNFalign_lite is 2% worse than the other two in terms of accuracy. For example, on all the CASP10 targets, CNFalign_lite obtains accumulative TMscore 74.1 while CNFalign_fast 75.5.

./CNFalign_lite -t template_name -q target_name [-l tpl_root] [-g tgt_root] [-d output_root]
./CNFalign_fast -t template_name -q target_name [-l tpl_root] [-g tgt_root] [-d output_root]
./CNFalign_normal -t template_name -q target_name [-l tpl_root] [-g tgt_root] [-d output_root]

./CNFalign_lite -q 2mm0 -t 2mm2A -d result/ #clickget

#output= 2mm2A 2mm0 50.570558 65 64 64. FIles: .cnfpred .fasta (in results folder)
#output= 5cyaA 2mm0 20.942674 268 64 41 also test on 2nd rank template 





#b) CNFsearch will call CNFalign (depending on the mode that we choose)- CNFalign_lite, _normal, _fast.
