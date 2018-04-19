TEX = mechsys_praktikum.tex
PDF = mechsys_praktikum.pdf

$(PDF): $(TEX)
	pdflatex $<

clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *~

distclean: clean
	rm -f $(PDF)
