xmlresume-tools
--

These are my tools for working with
[XML Resume](http://xmlresume.sourceforge.net/) documents. They produce the
stuff you see [over here](http://www.aaronstraupcope.com/resume/).

I wrote a Makefile to hide all the boring details and I run it like
this:

	make all RESUME=/path/to/resume-en.xml NAME=aaronstraupcope

This creates 5 copies of my resume: A plain-text version, an HTML version (with
an inline stylesheet), an XML version and two PDF versions one of which contains
personal information and references and another which does not.

(By default personal information and references are removed from all other
formats.)

The files are created in `xmlresume-tools/build` directory.

Requirements
--

You will need the [xsltproc](http://xmlsoft.org/xslt/xsltproc2.html) tool which
seems to come pre-installed on most machines today. If not it is installed as
part of the [libxml](http://xmlsoft.org/) library. You will also need a copy of
the Java interpreter for generating PDF files.

That should be it.

To do
--

* Use Bootstrap for .html resume
* Make the .txt resume output Markdown (maybe?)
* Make the .fo resume work with current versions of Fop (or consider just using wkpdf?)
