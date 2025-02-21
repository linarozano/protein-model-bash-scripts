#!/bin/bash
#Lrlrlr 050519 raptorx_score.sh
#script to process results of raptorx_score
#concatenate scores into one file using for loops
#run in directory containing seperate folders of raptorx downloaded results

find . -type f -name 'ModelRank*' -exec cat {} + > mergedscores #works!