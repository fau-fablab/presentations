TEX = physik_projektpraktikum.tex
PDF = physik_projektpraktikum.pdf

$(PDF): $(TEX)
	pdflatex $<

clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *~

distclean: clean
	rm -f $(PDF)
