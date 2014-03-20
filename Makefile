all: move pandoc rmd2md reducepdf

vignettes: 
	cd inst/stuff;\
Rscript -e 'library(knitr); knit("rinatVignette.Rmd")'

move:
	cp inst/stuff/rinat* vignettes

pandoc:
	cd vignettes;\
pandoc -H margins.sty rinatVignette.md -o rinatVignette.pdf --highlight-style=tango;\
pandoc -H margins.sty rinatVignette.md -o rinatVignette.html --highlight-style=tango

rmd2md:
	cd vignettes;\
cp rinatVignette.md rinatVignette.Rmd;\

reducepdf:
	Rscript -e 'tools::compactPDF("vignettes/rinatVignette.pdf", gs_quality = "ebook")';\
