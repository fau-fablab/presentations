TEX = stuzuko.tex
PDF = stuzuko.pdf

$(PDF): $(TEX)
	pdflatex $<

clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *~

distclean: clean
	rm -f $(PDF)
