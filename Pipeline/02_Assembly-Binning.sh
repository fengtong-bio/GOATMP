#!/bin/bash

########## Part2 Assembly and Binning ##########
metaSPAdes=./bin/metaspades.py
megahit=~/bin/megahit
bwa=~/bin/bwa
samtools=~/bin/samtools
metabat2=./bin/metabat2
jgi_summarize_bam_contig_depths=./bin/jgi_summarize_bam_contig_depths


### Step1: Assembly
mkdir -p ./04_metaSPAdes/

python ${metaSPAdes} \
	--pe1-1 03_bowtie2/${sampleID}_meta_clean_R1.fq.gz \
	--pe1-2 03_bowtie2/${sampleID}_meta_clean_R2.fq.gz \
	-k 35,45,55,65,75,85,95,105 \
	-t 20 \
	-m 180 \
	-o 04_metaSPAdes/${sampleID}/

mkdir -p ./05_megahit/

${megahit} \
	-1 03_bowtie2/${sampleID}_meta_clean_R1.fq.gz \
 	-2 03_bowtie2/${sampleID}_meta_clean_R2.fq.gz \
	-t 20
	-o 05_megahit/${sampleID}/


### Step2: Binning
mkdir -p ./06_metabat2/

${bwa} index 04_metaSPAdes/${sampleID}/scaffolds.fasta

${bwa} mem -t 20 \
	04_metaSPAdes/${sampleID}/scaffolds.fasta \
	03_bowtie2/${sampleID}_meta_clean_R1.fq.gz \
	03_bowtie2/${sampleID}_meta_clean_R2.fq.gz \
	| ${samtools} view -bS - > 06_metabat2/${sampleID}/${sampleID}.bam

${samtools} sort -@ 20 06_metabat2/${sampleID}/${sampleID}.bam > 06_metabat2/${sampleID}/${sampleID}.sort.bam

${jgi_summarize_bam_contig_depths} --outputDepth 06_metabat2/${sampleID}/${sampleID}.depth.txt \
	--pairedContigs 06_metabat2/${sampleID}//${sampleID}.paired.txt \
	--minContigLength 1000 \
	--minContigDepth 1 \
	06_metabat2/${sampleID}/${sampleID}.sort.bam

${metabat2} -t 20 \
	--inFile 04_metaSPAdes/${sampleID}/scaffolds.fasta \
	--outFile 06_metabat2/${sampleID}/${sampleID}_metabat_bins/bin \
	--abdFile 06_metabat2/${sampleID}/${sampleID}.depth.txt
