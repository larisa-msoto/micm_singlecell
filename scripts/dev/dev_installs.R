# Install packages from CRAN

install.packages(c("BiocManager","remotes","devtools","Seurat","tidyverse","gprofiler2","data.table","patchwork","viridis","ggsci"),repos="https://stat.ethz.ch/CRAN/")

# Install packages from BioConductor

BiocManager::install(c('SingleR','scRNAseq','BiocGenerics', 'DelayedArray', 'DelayedMatrixStats','limma', 'S4Vectors', 'SingleCellExperiment','SummarizedExperiment', 'batchelor', 'Matrix.utils'))

# Install packages from github

remotes::install_github('satijalab/seurat-wrappers')
devtools::install_github(c('satijalab/seurat-data','cole-trapnell-lab/leidenbase','cole-trapnell-lab/monocle3'))


