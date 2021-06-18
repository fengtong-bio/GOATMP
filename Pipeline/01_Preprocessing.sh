#!/bin/bash

########## Part1 QC: Quality control ##########
fastqc=~/bin/fastqc
trimmomatic=~/bin/trimmomatic-0.39.jar
adapters=./bin/TruSeq2-PE.fa
bowtie2_build=~/bin/bowtie2-build
bowtie2=~/bin/bowtie2
ref=./ref/Combined_genomic_ARS1_ZH13_B73_MtrunA17.fa
Rawdata=./00_RawData


### Step1: Quality control checks on raw sequence data
mkdir -p ./01_fastqc/

${fastqc} -t 20 \
	${Rawdata}/${sampleID}_R1.fq.gz \
	${Rawdata}/${sampleID}_R2.fq.gz \
	-o 01_fastqc


### Step2: Quality control
mkdir -p ./02_trimmomatic/

java -jar ${trimmomatic} PE -threads 20 \
	${Rawdata}/${sampleID}_R1.fq.gz \
	${Rawdata}/${sampleID}_R2.fq.gz \
	02_trimmomatic/${sampleID}_clean_R1.fq.gz \
	02_trimmomatic/${sampleID}_unpaired_R1.fq.gz \
	02_trimmomatic/${sampleID}_clean_R2.fq.gz \
	02_trimmomatic/${sampleID}_unpaired_R2.fq.gz \
	ILLUMINACLIP:${adapters}:2:30:10 SLIDINGWINDOW:15:30 MINLEN:110 TRAILING:30 AVGQUAL:30


### Step3: Remove host and food sequence
mkdir -p ./03_bowtie2/

${bowtie2_build} ${ref} ./ref/Goat_host_food.db

bowtie2 -x ./ref/Goat_host_food.db -p 20 --very-sensitive \
	-1 02_trimmomatic/${sampleID}_clean_R1.fq.gz \
	-2 02_trimmomatic/${sampleID}_clean_R2.fq.gz \
	--un-conc-gz 03_bowtie2/${sampleID}_meta_clean_R%.fq.gz \
	--al-conc-gz 03_bowtie2/${sampleID}_genome_clean_R%.fq.gz \
	--no-unal | samtools sort -o 03_bowtie2/${sampleID}_genome_clean.sort.bam
