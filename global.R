# OMNIPATH R
# Workshop Oct 2023
# 
# https://bioconductor.org/packages/release/bioc/vignettes/OmnipathR/inst/doc/bioc_workshop.html#introduction
#
# Through bioconductor: https://bioconductor.org/packages/release/bioc/html/OmnipathR.html
#
# IMPORTANT: Requires R.4.3!!!
#
#
#library(devtools)
#install_github('saezlab/OmnipathR')

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("OmnipathR")

install.packages("vroom")

