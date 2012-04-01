all: clean text html pdf

clean:
	rm -rf build/*.*

text:
	xsltproc -o build/resume.txt \
		--param header.address.display 0 \
		--param header.phone.display 0 \
		--param referees.display 0 \
		format/text.xsl $(RESUME)

html:
	xsltproc -o build/resume.html \
		--param header.address.display 0 \
		--param header.phone.display 0 \
		--param referees.display 0 \
		--param css.embed 1 \
		--stringparam css.href "../css/screen.css" \
		format/html.xsl $(RESUME)

pdf:
	xsltproc -o build/resume.fo \
		--param header.address.display 0 \
		--param header.phone.display 0 \
		--param referees.display 0 \
		format/fo.xsl $(RESUME)

	xsltproc -o build/resume-personal-data.fo \
		format/fo.xsl $(RESUME)

	./bin/fop-0.20.5/fop.sh build/resume.fo build/resume.pdf

	./bin/fop-0.20.5/fop.sh build/resume-personal-data.fo build/resume-personal-data.pdf
