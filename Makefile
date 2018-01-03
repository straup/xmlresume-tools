all: clean text html pdf xml clean-fo

clean:
	rm -rf build/*.*

clean-fo:
	rm -rf build/*.fo

xml:

	xsltproc -o build/$(NAME)-resume-en.xml \
		--param header.address.display 0 \
		--param header.phone.display 0 \
		--param referees.display 0 \
		format/xml.xsl $(RESUME)

text:
	xsltproc -o build/$(NAME)-resume-en.txt \
		--param header.address.display 0 \
		--param header.phone.display 0 \
		--param referees.display 0 \
		format/text.xsl $(RESUME)

html:
	xsltproc -o build/$(NAME)-resume-en.html \
		--param header.address.display 0 \
		--param header.phone.display 0 \
		--param referees.display 0 \
		--param css.embed 1 \
		--stringparam css.href "../css/resume.css" \
		format/html.xsl $(RESUME)

pdf:
	xsltproc -o build/$(NAME)-resume-en.fo \
		--param header.address.display 0 \
		--param header.phone.display 0 \
		--param referees.display 0 \
		format/fo.xsl $(RESUME)

	xsltproc -o build/$(NAME)-resume-en-personal-data.fo \
		format/fo.xsl $(RESUME)

	./bin/fop-0.20.5/fop.sh build/$(NAME)-resume-en.fo build/$(NAME)-resume-en.pdf

	./bin/fop-0.20.5/fop.sh build/$(NAME)-resume-en-personal-data.fo build/$(NAME)-resume-en-personal-data.pdf
