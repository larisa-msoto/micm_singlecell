FROM jupyter/datascience-notebook:latest

USER root

# Install python packages
RUN conda install -c bioconda scvelo \
	&& conda install -c bioconda scanpy 

# Install R packages

RUN Rscript -e "update.packages(ask=FALSE, repos='https://stat.ethz.ch/CRAN/')"
RUN Rscript -e "install.packages(c('BiocManager','remotes','devtools','Seurat','tidyverse','gprofiler2','data.table','patchwork','viridis','ggsci'),repos='https://stat.ethz.ch/CRAN/')"
RUN Rscript -e "BiocManager::install(c('SingleR','scRNAseq','BiocGenerics', 'slingshot'))"
RUN conda install -c bu_cnio r-seuratwrappers \
	&& conda install -c bioconda r-velocyto.r 
RUN Rscript -e "devtools::install_github('satijalab/seurat-data')"
RUN Rscript -e "devtools::install_github(repo = 'mojaveazure/loomR', ref = 'develop')"
RUN Rscript -e "BiocManager::install(c('limma','TENxBrainData','slingshot'))"

# Copy local files
COPY data/ /home/jovyan/data/

# Change permissions
RUN chmod -R 777 /home/jovyan

# Disable token for Jupyter 
CMD ["start-notebook.sh", "--ip='*'", "--NotebookApp.token=''", "--NotebookApp.password=''"]