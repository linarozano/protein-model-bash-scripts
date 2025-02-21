#!/usr/local/bin/python
#Lrlrlr 300519 finddup.py
#find duplicates sequences in a list of fasta files
#EffectorP v1 and v2 fasta

from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import IUPAC
from collections import defaultdict

dedup_records = defaultdict(list)
for record in SeqIO.parse("test.fasta", "fasta"):
    # Use the sequence as the key and then have a list of id's as the value
    dedup_records[str(record.seq)].append(record.id)

# this creates a generator; if you need a physical list, replace the outer "(", ")" by "[" and "]", respectively
final_seq = (SeqRecord(Seq(seqi, IUPAC.protein), id="|".join(gi), name='', description='') for seqi, gi in dedup_records.items())

# write file
SeqIO.write(final_seq, 'test_output_final.fasta', 'fasta')
