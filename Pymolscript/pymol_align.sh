#!/bin/bash
#Lrlrlr 020419 pymol_align.sh
#Collections of structural alignment tools in pymol_align

#align performs a sequence alignment followed by a structural superposition, and then carries out zero or more cycles of refinement in order to reject structural outliers found during the fit. align does a good job on proteins with decent sequence similarity (identity >30%). For comparing proteins with lower sequence identity, the super and cealign commands perform better.
#super aligns two selections. It does a sequence-independent (unlike align) structure-based dynamic programming alignment followed by a series of refinement cycles intended to improve the fit by eliminating pairing with high relative variability (just like align). super is more robust than align for proteins with low sequence similarity.
#cealign aligns two proteins using the CE algorithm. It is very robust for proteins with little to no sequence similarity (twilight zone). For proteins with decent structural similarity, the super command is preferred and with decent sequence similarity, the align command is preferred, because these commands are much faster than cealign.