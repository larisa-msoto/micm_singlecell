docker run -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v "$PWD":/home/jovyan -d larisamsoto/micm_singlecell

docker run -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -d larisamsoto/micm_singlecell
