###
### generic GNU make Makefile for .tex -> .pdf.
### ransford at cs.washington.edu
###   http://github.com/ransford/pdflatex-makefile
###
### Recommended usage:
###   1. echo 'include Makefile.include' > Makefile
###   2. Optional: Edit the Makefile to override $(TARGET)
###      and anything else (e.g., PDFVIEWER, AFTERALL)
###
### Final result:
###   % cat Makefile
###   TARGET=mypaper
###   PDFVIEWER=open -a 'Adobe Acrobat Professional'
### AFTERALL=
###   include Makefile.include
###
###   mypostprocessingstep:
###           # do something...
###

TARGET=vektorzeichnen_mit_inkscape kassenterminal
HTML5TARGETS=matherep-reveal.html fab12.html

PDFLATEX	?= pdflatex -halt-on-error -file-line-error
BIBTEX		?= bibtex

ifneq ($(QUIET),)
PDFLATEX	+= -interaction=batchmode
ERRFILTER	:= > /dev/null || (egrep ':[[:digit:]]+:' *.log && false)
BIBTEX		+= -terse
else
PDFLATEX	+= -interaction=nonstopmode
ERRFILTER=
endif

## Action for 'make view'
OS=$(shell uname -s)
ifeq ($(OS),Darwin)
PDFVIEWER	?= open
else
PDFVIEWER	?= xdg-open
endif

## Name of the target file, minus .pdf: e.g., TARGET=mypaper causes this
## Makefile to turn mypaper.tex into mypaper.pdf.
TARGETS += $(TARGET)
TEXTARGETS = $(TARGETS:=.tex)
PDFTARGETS = $(TARGETS:=.pdf)
AUXFILES   = $(TARGETS:=.aux)
LOGFILES   = $(TARGETS:=.log)

## If $(TARGET).tex refers to .bib files like \bibliography{foo,bar}, then
## $(BIBFILES) will contain foo.bib and bar.bib, and both files will be added as
## dependencies to $(PDFTARGETS).
## Effect: updating a .bib file will trigger re-typesetting.
BIBFILES = $(patsubst %,%.bib,\
		$(shell grep '^[^%]*\\bibliography{' $(TEXTARGETS) | \
			grep -o '\\bibliography{[^}]\+}' | \
			sed -e 's/^[^%]*\\bibliography{\([^}]*\)}.*/\1/' \
			    -e 's/, */ /g'))

## Add \input'ed or \include'd files to $(PDFTARGETS) dependencies.
INCLUDEDTEX = $(patsubst %,%.tex,\
		$(shell grep '^[^%]*\\\(input\|include\){' $(TEXTARGETS) | \
			grep -o '\\\(input\|include\){[^}]\+}' | \
			sed -e 's/^.*{\([^}]*\)}.*/\1/'))

AUXFILES += $(INCLUDEDTEX:.tex=.aux)

## grab a version number from the repository (if any) that stores this.
## * REVISION is the current revision number (short form, for inclusion in text)
## * VCSTURD is a file that gets touched after a repo update
SPACE = $(empty) $(empty)
ifeq ($(shell git status >/dev/null 2>&1 && echo USING_GIT),USING_GIT)
  ifeq ($(shell git svn info >/dev/null 2>&1 && echo USING_GIT_SVN),USING_GIT_SVN)
    # git-svn
    REVISION := $(shell git svn find-rev git-svn)
    VCSTURD := $(subst $(SPACE),\ ,$(shell git rev-parse --show-toplevel)/.git/refs/remotes/git-svn)
  else
    # plain git
    REVISION := $(shell git rev-parse --short HEAD)
    GIT_BRANCH := $(shell git symbolic-ref HEAD 2>/dev/null)
    VCSTURD := $(subst $(SPACE),\ ,$(shell git rev-parse --show-toplevel)/.git/$(GIT_BRANCH))
  endif
else ifeq ($(shell hg root >/dev/null 2>&1 && echo USING_HG),USING_HG)
  # mercurial
  REVISION := $(shell hg id -i)
  VCSTURD := $(subst $(SPACE),\ ,$(shell hg root)/.hg/dirstate)
else ifneq ($(wildcard .svn/entries),)
  # subversion
  REVISION := $(subst :,-,$(shell svnversion -n))
  VCSTURD := .svn/entries
endif

# .PHONY names all targets that aren't filenames
.PHONY: all clean pdf view snapshot distill distclean clean-output copy-output compile-html-assets clean-html-assets copy-html-assets subfolders

all: pdf copy-output subfolders $(AFTERALL)

pdf: $(PDFTARGETS)

subfolders:
	$(MAKE) -C physik_projektpraktikum
	$(MAKE) -C mechsys_praktikum
	cp physik_projektpraktikum/physik_projektpraktikum.pdf output/
	cp mechsys_praktikum/mechsys_praktikum.pdf output/

view: $(PDFTARGETS)
	$(PDFVIEWER) $(PDFTARGETS)

# define a \Revision{} command you can include in your document's preamble.
# especially useful with e.g. draftfooter.sty or fancyhdr.
# usage: \input{revision}
#        ... \Revision{}
ifneq ($(REVISION),)
REVDEPS += revision.tex
revision.tex: $(VCSTURD)
	/bin/echo '\newcommand{\Revision}'"{$(REVISION)}" > $@
AUXFILES += revision.aux
endif

# to generate aux but not pdf from pdflatex, use -draftmode
.INTERMEDIATE: $(AUXFILES)
%.aux: %.tex $(REVDEPS)
	$(PDFLATEX) -draftmode $* $(ERRFILTER)

# introduce BibTeX dependency if we found a \bibliography
ifneq ($(strip $(BIBFILES)),)
BIBDEPS = %.bbl
%.bbl: %.aux $(BIBFILES)
	$(BIBTEX) $*
endif

$(PDFTARGETS): %.pdf: %.tex %.aux $(BIBDEPS) $(INCLUDEDTEX) $(REVDEPS)
	$(PDFLATEX) $* $(ERRFILTER)
ifneq ($(strip $(BIBFILES)),)
	@if grep -q "undefined references" $*.log; then \
		$(BIBTEX) $* && $(PDFLATEX) $* $(ERRFILTER); fi
endif
	@while grep -q "Rerun to" $*.log; do \
		$(PDFLATEX) $* $(ERRFILTER); done

DRAFTS := $(PDFTARGETS:.pdf=-$(REVISION).pdf)
$(DRAFTS): %-$(REVISION).pdf: %.pdf
	cp $< $@
snapshot: $(DRAFTS)

%.distilled.pdf: %.pdf
	gs -q -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=$@ \
		-dCompatibilityLevel=1.5 -dPDFSETTINGS=/prepress -c .setpdfwrite -f $<
	exiftool -overwrite_original -Title="" -Creator="" -CreatorTool="" $@

distill: $(PDFTARGETS:.pdf=.distilled.pdf)

distclean: clean
	$(RM) $(PDFTARGETS) $(PDFTARGETS:.pdf=.distilled.pdf) $(EXTRADISTCLEAN)
	$(MAKE) distclean -C physik_projektpraktikum
	$(MAKE) distclean -C mechsys_praktikum

clean: clean-output clean-html-assets
	$(RM) $(foreach T,$(TARGETS), \
		$(T).out $(T).blg $(T).bbl \
		$(T).lof $(T).lot $(T).toc $(T).idx \
		$(T).nav $(T).snm) \
		$(REVDEPS) $(AUXFILES) $(LOGFILES) \
		$(EXTRACLEAN)
	$(MAKE) clean -C physik_projektpraktikum
	$(MAKE) clean -C mechsys_praktikum

copy-output: pdf copy-html-assets
	mkdir -p output
	cp $(PDFTARGETS) output/
	cp $(HTML5TARGETS) output/

compile-html-assets:
	find -name "*.svg" -print0 | xargs -0 -I '{}' inkscape --export-png="{}.png" {}
	$(foreach P,$(HTML5TARGETS), \
		sed -i "s/.svg\"/.svg.png\"/g" $(P) \
	)

copy-html-assets:
	# reveal.js
	mkdir -p output/reveal.js/
	cp -ra reveal.js/css/ reveal.js/lib/ reveal.js/js/ reveal.js/LICENSE reveal.js/plugin/ output/reveal.js/
	# own files
	cp -ra img/ output/img/
	cp -ra fab12-img/ output/fab12-img/
	cp -ra style/ output/style/
	# WORKAROUND during license cleanup
	rm output/img/fraese-lego.png

clean-html-assets:
	find -name "*.svg.png" -delete
	$(foreach P,$(HTML5TARGETS), \
		sed -i "s/.svg.png\"/.svg\"/g" $(P) \
	)

clean-output:
	rm -rf output/
