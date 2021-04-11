#!/usr/bin/env Rscript

suppressPackageStartupMessages({
    library(Biostrings)
    library(GenomicFeatures)
    library(SummarizedExperiment)
    library(tximeta)
    library(SingleCellExperiment)
    library(BSgenome)
    library(eisaR)
    library(rjson)
    library(reticulate)
    library(scater)
})

# Inputs args

args = commandArgs(trailingOnly=TRUE)
refpath<-args[1]
mode<-args[2]

if(mode=='generate'){

    print(":: Running on generate mode to build the reference")
  
    # Define genomic positions of interest

    print(":: Defining regions")
    gtf <- paste(refpath,"/gencode.vM24.annotation.gtf.gz",sep="")
    grl <- eisaR::getFeatureRanges(
      gtf = gtf,
      featureType = c("spliced", "intron"), 
      intronType = "separate", 
      flankLength = 90L, 
      joinOverlappingIntrons = FALSE, 
      verbose = TRUE
    )

    # Fetch the sequences
    print(":: Fetching sequences")
    gfile<-paste(refpath,"/GRCm38.primary_assembly.genome.fa",sep="")
    genome <- Biostrings::readDNAStringSet(gfile)
    names(genome) <- sapply(strsplit(names(genome), " "), .subset, 1)
    seqs <- GenomicFeatures::extractTranscriptSeqs(x = genome, transcripts = grl)
    Biostrings::writeXStringSet(seqs, filepath = paste(refpath,"/gencode.vM24.annotation.expanded.fa",sep=""))

    # Write expanded GTF file 
    print(":: Exporting to gtf file")
    eisaR::exportToGtf(grl, filepath = paste(refpath,"/gencode.vM24.annotation.expanded.gtf",sep=""))

    # Write metadata
    print(":: Writing smaple metadata")
    write.table(metadata(grl)$corrgene, 
                file = paste(refpath,"/gencode.vM24.annotation.expanded.features.tsv",sep=""),
                row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

    # Write intron-transcript-gene map table 
    df <- eisaR::getTx2Gene(grl, filepath = paste(refpath,"/gencode.vM24.annotation.expanded.tx2gene.tsv",sep=""))

}else if(mode=='link'){

    print(":: Running on link mode to make linked genome with tximeta")

    index.path<-paste(refpath,"/gencode.vM24.annotation.expanded.sidx",sep="")
    fasta.path<-paste(refpath,"/gencode.vM24.annotation.expanded.fa",sep="")
    gtf.path<-paste(refpath,"/gencode.vM24.annotation.expanded.gtf",sep="")
    json.path<-paste(refpath,"/gencode.vM24.annotation.expanded.json",sep="")

    tximeta::makeLinkedTxome(
        indexDir = index.path, 
        source = "GENCODE", 
        genome = "GRCm38", 
        organism = "Mus musculus", 
        release = "M24", 
        fasta = fasta.path, 
        gtf = gtf.path, 
        write = TRUE, 
        jsonFile = json.path)
}