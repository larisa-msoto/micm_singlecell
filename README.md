# Introduction to single cell analysis concepts

This workshop intends to introduce the basic concepts underlying single-cell data generation, processing and analysis. We will introduce the current state-of-the-art technologies for molecular profiling at the single cell level. The goal is to help participants get familiar with existing tools and understand the differences between them. 

## Installations

It is highly recommended to setup the Docker image for the workshop, it will download the data and setup all the required packages. If you run into issues you can follow the steps listed in the Manual section to do the installations and download the data on your own.

### Using Docker

---

1. Download Docker Desktop App from their [website](https://www.docker.com/products/docker-desktop)

2. Pull the image

```bash
docker pull larisamsoto/micm_singlecell
```
3. Run the container 

To enable jupyter lab - this option will not work on Safari

```bash
docker run -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes --name micm-single-cell larisamsoto/micm_singlecell
```

If you prefer to use Jupyter Notebook

```bash
docker run -p 8888:8888 --name micm-single-cell larisamsoto/micm_singlecell
```

If the container stops during the workshop and you need to re-start it

```bash
docker start micm-single-cell -a
```

4. To open the Jupyter server in a browser (preferably chrome) jus copy and paste one of the following URLs

``
https://127.0.0.1:8888/lab 
``

``
https://localhost:8888/lab 
``

### Manual

---

1. Make sure you have installed Python 3.8.8 and R 4.0.3

2. Install the required Python packages using conda

```python
conda install -c bioconda scvelo 
conda install -c bioconda scanpy 
```

2. Install the required R packages 

**From CRAN**

```r
install.packages(c('BiocManager','remotes','devtools','Seurat','tidyverse','gprofiler2','data.table','patchwork','viridis','ggsci'))
```

**From Bioconductor**

```r
BiocManager::install(c('SingleR','scRNAseq','BiocGenerics', 'slingshot','limma','TENxBrainData')))
```

**From Anaconda**

```bash
conda install -c bu_cnio r-seuratwrappers 
conda install -c bioconda r-velocyto.r 
```

**From Github**

```
devtools::install_github('satijalab/seurat-data')
devtools::install_github(repo = 'mojaveazure/loomR', ref = 'develop')
```

3. Clone this repository

```bash
git clone https://github.com/larisa-msoto/micm_singlecell.git
```

4. Download the data using this [OneDrive link](https://mcgill-my.sharepoint.com/:f:/g/personal/larisa_moralessoto_mail_mcgill_ca/Eh8_BuTesm9DnKqByzvHE14BYseJkMRmjUpGnxdLLA3U2Q?e=hvoUgy
) into the folder `data`



