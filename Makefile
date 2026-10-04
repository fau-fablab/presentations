# Baut alle Präsentationen als PDF nach output/: make
#
# Neue Präsentation: Name in TARGET (name.tex im Hauptordner) oder in
# SUBDIRS (ordner/ordner.tex) eintragen.

# Präsentationen im Hauptordner
TARGET = kassenterminal kurzvorstellung_fuer_workshops vektorzeichnen_mit_inkscape
# Präsentationen in eigenen Ordnern
SUBDIRS = innovationslabor matherep mechsys_praktikum physik_projektpraktikum stuzuko

LATEXMK ?= latexmk -pdf -interaction=nonstopmode -halt-on-error

PDFS = $(TARGET:=.pdf) $(foreach d,$(SUBDIRS),$(d)/$(d).pdf)

# Version, z.B. für die GitHub Action: make -s version
# Standard: Datum des letzten Commits (JJJJ.MM.TT), bei nicht committeten
# Änderungen mit "-entwurf". Überschreiben mit "make VERSION=...".
ifeq ($(VERSION),)
VERSION := $(shell TZ=Europe/Berlin git log -1 --format=%cd --date=format-local:%Y.%m.%d 2>/dev/null)
ifneq ($(VERSION),)
ifneq ($(shell git status --porcelain --untracked-files=no 2>/dev/null),)
VERSION := $(VERSION)-entwurf
endif
endif
endif

.PHONY: all pdf clean distclean version FORCE

# output/ enthält genau die PDFs aus TARGET und SUBDIRS
all: pdf
	mkdir -p output
	find output/ -name "*.pdf" -delete
	cp $(PDFS) output/

pdf: $(PDFS)

# latexmk entscheidet selbst, ob neu gebaut werden muss
%.pdf: %.tex FORCE
	cd $(dir $<) && $(LATEXMK) $(notdir $<)

FORCE:

version:
	@echo $(VERSION)

clean:
	$(foreach f,$(PDFS:.pdf=.tex),(cd $(dir $(f)) && $(LATEXMK) -C -e '$$clean_ext = "nav snm vrb"' $(notdir $(f)));)
	rm -rf output/

distclean: clean
