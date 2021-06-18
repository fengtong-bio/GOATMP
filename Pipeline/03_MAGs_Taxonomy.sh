#!/bin/bash

########## Part3 Taxonomic annotation for MAGs ##########
dRep=~/bin/dRep
gtdbtk=~/bin/gtdbtk

### Step1: Dereplication for all bins by drep
mkdir -p ./07_dRep/
mkdir -p ./07_dRep/all_bins/

ln -s 06_metabat2/${sampleID}/${sampleID}_metabat_bins/bin/* 07_dRep/all_bins/

${dRep} dereplicate 07_dRep/all_bins_dRep \
	-p 20 \
	-comp 80 \
	-con 10 \
	-str 100 \
	-strW 0 \
	-g 07_dRep/all_bins/*


### Step2: MAGs classification by GTDB-TK
mkdir -p ./08_GTDB_TK/

${gtdbtk} classify_wf \
	--genome_dir 07_dRep/all_bins_dRep/dereplicated_genomes \
	-x fa \
	--out_dir 08_GTDB_TK/classify_wf_out \
	--cpus 20
