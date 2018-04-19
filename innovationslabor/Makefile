TEX = innovationslabor.tex
PDF = innovationslabor.pdf

$(PDF): $(TEX)
	pdflatex $<

clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *~

distclean: clean
	rm -f $(PDF)
