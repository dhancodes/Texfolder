TEX = pdflatex --synctex=1 -interaction=nonstopmode 
BIB = biber
TEX2EPS = ~/.scripts/tex2eps
TEX_DIR = ./fig
FIGS = fig/*.tex
FIGFILES := $(wildcard $(TEX_DIR)/*.tex)
EPSFILES := $(patsubst %tex,%eps,$(FIGFILES))
CLEAN_EXTENSIONS = *.aux *.log *.toc *.out *.bcf *.run.xml *.bbl *.blg fig/*.log *.synctex.gz
CURRENT_DATE := $(shell date +%Y%m%d)
VERSION := $(shell date +%Y%m%d)



.PHONY: all view clean distclean fig bibfiles

all : main.pdf fig

view : main.pdf
	xdg-open main.pdf

clean:
	@rm -f $(CLEAN_EXTENSIONS)

distclean: clean
	@rm -f main.pdf main.dvi main.ps
	@rm $(EPSFILES)

fig: $(EPSFILES)

$(TEX_DIR)/%.eps: $(TEX_DIR)/%.tex
	$(TEX2EPS) "$<"

main.pdf : main.tex bibfiles
	-$(TEX) main.tex

bibfiles : main.aux
	-$(BIB) main

main.aux : main.tex
	-$(TEX) main.tex
