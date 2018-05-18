#!/bin/sh

for pack in "$@"
do
    R -e "install.packages('$pack', repos='http://cran.rstudio.com/')"
done
