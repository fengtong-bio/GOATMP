#!/bin/bash

########## Part4 Functional annotation for MAGs ##########
prokka=~/bin/prokka
MAGsID=07_dRep/all_bins_dRep/dereplicated_genomes/*fa
cdhit=~/bin/cd-hit
eggnog=./bin/emapper.py
eggnog_db=./bin/eggnog.db
dbcan2_db=./dbCAN2/Tools/run_dbcan/db/
hmmscan=./bin/hmmscan
hmmscan-parser=~/bin/hmmscan-parser.sh


### Step1: Protein prediction by Prokka
mkdir -p ./09_prokka/

${prokka} ${MAGsID} \
	--outdir 09_prokka/${MAGsID} \
	--prefix ${MAGsID} \
	--kingdom Bacteria \
	--force \
	--norrna \
	--notrna \
	--cpus 20

### Step2: cluster all proteins by CD-HIT
mkdir -p ./10_cd-hit

cat ./09_prokka/*faa > 10_cd-hit/MAGs_all_pro.fa

cat ./09_prokka/*ffn > 10_cd-hit/MAGs_all_nuc.fa

${cdhit} -i 10_cd-hit/MAGs_all_pro.fa \
	-c 0.95 \
	-aS 0.90 \
	-o 10_cd-hit/MAGs_ununique_pro.fa \
	-T 40 \
	-M 0

${cdhit} -i 10_cd-hit/MAGs_all_nuc.fa \
        -c 0.95 \
        -aS 0.90 \
        -o 10_cd-hit/MAGs_ununique_nuc.fa \
        -T 40 \
        -M 0

### Step3: COG annotation by eggNOG-mapper
mkdir -p ./11_eggNOG/

cd 11_eggNOG

split -l 20000 -a 3 -d ../10_cd-hit/MAGs_ununique_pro.fa protenin.chunk_

time parallel -j 4 --xapply \
	'${eggnog} -m diamond --no_annot --no_file_comments --cpu 10 -i {1} -o {1}' \
	::: protenin.chunk_*

cat *seed_orthologs > protenin.seed_orthologs

${eggnong} --annotate_hits_table protenin.seed_orthologs \
	--no_file_comments \
	-o protenin_annotate \
	--cpu 40 \
	--data_dir ${eggnog_db} \
	--override

cd ../

### Step4: CAZy annotation by dbCAN2
mkdir -p ./12_CAZy/

cd 12_CAZy

split -l 20000 -a 3 -d ../10_cd-hit/MAGs_ununique_pro.fa protenin.chunk_

time parallel -j 80 --xapply \
	'${hmmscan} --cpu 1 --domtblout {1}.out.dm ${dbcan2_db} {1} > {1}.out' \
	::: protenin.chunk_*

cat *out.dm > CAZy.out.dm

sh ${hmmscan-parser} CAZy.out.dm > CAZy.out.dm.ps

cat CAZy.out.dm.ps | awk '$5<1e-15&&$10>0.35' > CAZy.out.dm.ps.stringent

cd ../
