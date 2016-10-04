SVGS=$(wildcard *.svg)
EXTRA_DEPS=3d-turm.png platine.png zahnraeder2b.png
PDFS=$(SVGS:%.svg=%.pdf)

.PHONY: all clean

all: $(PDFS)

%.pdf: %.svg $(EXTRA_DEPS)
	svg2pdf $< $@

clean:
	$(RM) $(PDFS)
