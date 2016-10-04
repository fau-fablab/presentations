SHELL=/bin/bash
TARGET=fflbeamer
TGZ=fflbeamer.tgz
# TARGET=handout
# TGZ=handout.tgz
LATEX=latex
PDFLATEX=pdflatex
BIBTEX=bibtex
MAKEIDX=makeindex
DVIPS=dvips

TEX= $(wildcard *.tex)
BIB= $(wildcard *.bib)
STYLES= $(wildcard *.sty)
MISC= Makefile

EPS= $(wildcard eps/*.eps)

JPG= $(wildcard jpg/*.jpg)

FIG= $(wildcard fig/*.fig)

SVG= $(wildcard svg/*.svg)

TEXFIG= $(wildcard texfig/*.fig)

BILDER = $(EPS) $(JPG) $(FIG) $(wildcard fig/*.*ps) $(TEXFIG) $(wildcard texfig/*.*ps)

EPS_C= $(EPS:eps/%.eps=eps_c/%.pdf)
JPG_C= $(JPG:jpg/%.jpg=jpg_c/%.eps)
FIG_PS = $(FIG:fig/%.fig=fig_c/%.eps)
FIG_PDF= $(FIG:fig/%.fig=fig_c/%.pdf)
SVG_PDF= $(SVG:svg/%.svg=svg_c/%.pdf)
TEXFIG_TEX= $(TEXFIG:texfig/%.fig=texfig_c/%.pstex_t)
TEXFIG_PS = $(TEXFIG:texfig/%.fig=texfig_c/%.pstex)
TEXFIG_PDF= $(TEXFIG:texfig/%.fig=texfig_c/%.pdf)

FILES= $(TEX) $(BIB) $(MISC) $(STYLES)


.PHONY=all ps ps! pdf pdf! small booklet clean cleanall run

#INKSCAPE="/cygdrive/f/Programs/Inkscape/inkscape.exe"
#WINDIR=$(shell cygpath -a -m .)/
READER="/cygdrive/f/C_Programs/Adobe/Reader 9.0/Reader/AcroRd32.exe"

INKSCAPE="inkscape"
WINDIR="./"
READER="okular"

# Bilder-Konvertierung: eps -> pdf
eps_c/%.pdf: eps/%.eps
	@echo Konvertiere $< nach $@
	GS_OPTIONS=-dAutoRotatePages=/None epstopdf $< -o $@

# Bilder-Konvertierung: jpg -> eps
jpg_c/%.eps: jpg/%.jpg
	@echo Konvertiere $< nach $@
	jpeg2ps $< > $@

# Bilder-Konvertierung: fig -> eps
fig_c/%.eps: fig/%.fig
	@echo Konvertiere $< nach $@eps
	fig2dev -L eps $< > $@

# Bilder-Konvertierung: fig -> pdf
fig_c/%.pdf: fig_c/%.eps
	@echo Konvertiere $< nach $@
	GS_OPTIONS=-dAutoRotatePages=/None epstopdf $< -o $@
	
# Bilder-Konvertierung: svg -> pdf
svg_c/%.pdf: svg/%.svg
	@echo Konvertiere $< nach $@
	# @echo $(CURDIR)
	$(INKSCAPE) -f "$(WINDIR)$<" -A "$(WINDIR)$@"
	
# Biler-Konvertierung: Combined LaTeX / PostScript (PDF)
texfig_c/%.pstex_t: texfig/%.fig
	@echo Konvertiere $< nach $@
	fig2dev -L pstex_t $< | ./scripts/modify_pstex_t.pl $< > $@
texfig_c/%.pstex: texfig/%.fig
	@echo Konvertiere $< nach $@
	fig2dev -L pstex $< > $@
texfig_c/%.pdf: texfig_c/%.pstex
	@echo Konvertiere $< nach $@
	GS_OPTIONS=-dAutoRotatePages=/None epstopdf $< -o $@

all: pdf

ps: $(TARGET).ps

ps!: rmps ps

rmps:
	rm -f $(TARGET).dvi $(TARGET).ps $(TARGET).booklet.ps

$(TARGET).dvi: $(FILES) $(EPS) $(JPG_C) $(SVG_PDF) $(FIG_PS) $(TEXFIG_TEX) $(TEXFIG_PS)
	$(LATEX) $(TARGET)
	
#	$(MAKEIDX) $(TARGET)
	$(LATEX) $(TARGET)
	$(BIBTEX) $(TARGET)
	$(LATEX) $(TARGET)
	$(BIBTEX) $(TARGET)
	
	$(LATEX) $(TARGET)

$(TARGET).ps: $(TARGET).dvi
	$(DVIPS) -t a4 $(TARGET).dvi # -Pcm-super

small: $(FILES) $(EPS_C) $(JPG) $(FIG_PDF) $(SVG_PDF) $(TEXFIG_TEX) $(TEXFIG_PDF)
	$(PDFLATEX) $(TARGET)

rubber_loop:
	# --quiet 
	bash -c "for (( ; ; )) ; do time rubber --cache --pdf $(TARGET).tex ; sleep 1 ; done"

pdf: $(TARGET).pdf

pdf!: rmpdf pdf

rmpdf:
	rm -f $(TARGET).pdf

$(TARGET).pdf: $(FILES) $(EPS_C) $(JPG) $(FIG_PDF) $(SVG_PDF) $(TEXFIG_TEX) $(TEXFIG_PDF)
	$(PDFLATEX) $(TARGET)
	$(PDFLATEX) $(TARGET)
	
#	$(MAKEIDX) $(TARGET)
#	$(PDFLATEX) $(TARGET)
#	$(BIBTEX) $(TARGET)
#	$(PDFLATEX) $(TARGET)
#	$(BIBTEX) $(TARGET)

#	$(PDFLATEX) $(TARGET)

checkin:
	ci -l $(TEX)

booklet: $(TARGET).booklet.ps

$(TARGET).booklet.ps: $(TARGET).ps
	./scripts/booklet $(TARGET).ps

rmfigc:
	rm -f eps_c/* 
	rm -f jpg_c/* 
	rm -f fig_c/* 
	rm -f texfig_c/*
	rm -f svg_c/*

clean:
	rm -f *.aux
	rm -f *.bbl
	rm -f *.blg
	rm -f *.idx
	rm -f *.ilg
	rm -f *.ind
	rm -f *.lof
	rm -f *.log
	rm -f *.lot
	rm -f *.nav
	rm -f *.org
	rm -f *.out
	rm -f *.snm
	rm -f *.toc
	rm -f *.vim
	rm -f *~

cleanall: clean rmps rmpdf rmfigc

run: $(TARGET).pdf
	$(READER) $(WINDIR)$(TARGET).pdf
