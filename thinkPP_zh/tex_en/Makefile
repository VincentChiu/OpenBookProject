LATEX = latex

DVIPS = dvips

PDFFLAGS = -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress \
           -dCompressPages=true -dUseFlateCompression=true  \
           -dEmbedAllFonts=true -dSubsetFonts=true -dMaxSubsetPct=100


%.dvi: %.tex
	$(LATEX) $<

%.ps: %.dvi
	$(DVIPS) -o $@ $<

%.pdf: %.ps
	ps2pdf $(PDFFLAGS) $<

all:	book.tex
	latex book
	makeindex book
	latex book
#	dvips -T 6.75in,9.25in -Ppdf -o thinkPP.ps book
	dvips -t letter -Ppdf -o thinkPP.ps book
	gv thinkPP.ps

html:	book.tex
	rm -rf html
	mkdir html
	hevea -e latexonly htmlonly book
	# the following line is a kludge to prevent imagen from seeing
	# the definitions in latexonly
	grep -v latexonly book.image.tex > a; mv a book.image.tex
	imagen -png book
	hacha book.html
	mv index.html book*.html book*.png html

DEST = /home/downey/public_html/greent/thinkpython

distrib:
	ps2pdf $(PDFFLAGS) thinkPP.ps
	rm -rf dist
	mkdir dist dist/tex
	rsync -a thinkPP.pdf thinkPP.ps html dist
	rsync -a Makefile book.tex latexonly htmlonly figs dist/tex
	rm dist/tex/figs/*.bak
	cd dist/tex; make clean
	cd dist; zip -r thinkPPtex.zip tex
	cd dist; zip -r thinkPPhtml.zip html
	rsync -a dist/* $(DEST)
	chmod -R o+r $(DEST)/*

clean:
	rm -f *~ *.aux *.log *.dvi *.idx *.ilg *.ind *.toc



