pdf:	PTXdist-Manual.pdf
dvi:	PTXdist-Manual.dvi

final:	
	pdflatex PTXdist-Manual
	pdflatex PTXdist-Manual

.PHONY: PTXdist-Manual.pdf
PTXdist-Manual.pdf: PTXdist-Manual.tex
	pdflatex PTXdist-Manual

.PHONY: PTXdist-Manual.dvi
PTXdist-Manual.dvi: PTXdist-Manual.tex
	latex PTXdist-Manual

.PHONY: clean
clean:
	rm -f *.aux *.log *.dvi *.out *.toc *.idx
	rm -f PTXdist-Manual.pdf PTXdist-Manual.ps
