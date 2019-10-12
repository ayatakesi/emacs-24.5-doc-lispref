.PHONY: clean

# デフォルトは単一html、分割html、info
all: single-html multi-html info

# 単一html用のターゲット
single-html: elisp-ja.html

# 分割html用のターゲット
# html/*.htmlが生成されます
multi-html: html/index.html

# info用のターゲット
info: elisp-ja.info

# ASCII text用のターゲット
txt: elisp-ja.txt

# pdf用のターゲット(オプション)
pdf: elisp-ja.pdf

# tar.gz用のターゲット(オプション)
tar: elisp-ja.texis.tar.gz

# EPUB用のターゲット(オプション、experimental)
epub: elisp-ja.epub

# texinfo-js用のターゲット(オプション、experimental)
texinfo-js: elisp-ja-html/index.html

TEXIS := \
elisp.texi \
control.texi \
functions.texi \
lists.texi \
objects.texi \
symbols.texi \
customize.texi \
hash.texi \
macros.texi \
sequences.texi \
variables.texi \
eval.texi \
intro.texi \
numbers.texi \
strings.texi \
loading.texi \
compile.texi \
debugging.texi \
edebug.texi \
streams.texi \
minibuf.texi \
commands.texi \
keymaps.texi \
modes.texi \
help.texi \
files.texi \
backups.texi \
buffers.texi \
windows.texi \
frames.texi \
positions.texi \
markers.texi \
text.texi \
nonascii.texi \
searching.texi \
syntax.texi \
abbrevs.texi \
processes.texi \
display.texi \
os.texi \
package.texi \
anti.texi \
tips.texi \
internals.texi \
errors.texi \
maps.texi \
hooks.texi \
emacsver.texi \
doclicense.texi \
gpl.texi \
index.texi

JA_SUFFIX := "-ja"

clean:
	rm -f *.texi
	rm -f *.html
	rm -fR html/
	rm -f *.info
	rm -f *.pdf
	rm -f *-ja.txt
	rm -f *.tar.gz
	rm -fR elisp-ja.texis/
	rm -fR *.epub *.docbook mimetype META-INF OEBPS
	rm -fR elisp-ja-html/

%.texi:
	if [ -f $@.po ]; \
	then \
		JA_TEXI=$$(printf "%s%s%s" $* ${JA_SUFFIX} .texi); \
		./_convert.sh; \
		po4a-translate -f texinfo -k 0 -M utf8 -m original_texis/$@ -p $@.po -l $${JA_TEXI}; \
		./replace.sh $${JA_TEXI}; \
	else \
		cp -pf original_texis/$@ $@; \
	fi; \

elisp-ja.html: $(TEXIS)
	texi2any --set-customization-variable TEXI2HTML=1 elisp-ja.texi

html/index.html: $(TEXIS)
	makeinfo -o html/ --html elisp-ja.texi

elisp-ja.info: $(TEXIS)
	makeinfo --no-split -o elisp-ja.info elisp-ja.texi

elisp-ja.pdf: $(TEXIS)
	TEX=ptex texi2dvi -c elisp-ja.texi
	dvipdfmx elisp-ja.dvi
	rm -f elisp-ja.dvi

elisp-ja.txt: $(TEXI)
	texi2any --plaintext elisp-ja.texi > elisp-ja.txt

elisp-ja.texis.tar.gz: $(TEXIS)
	if [ ! -d elisp-ja.texis ]; \
	then \
		mkdir elisp-ja.texis/; \
	fi

	cp -fp *.texi elisp-ja.texis
	tar cvfz ./elisp-ja.texis.tar.gz ./elisp-ja.texis

# EXPERIMENTAL
# REQUIRES: xsltproc, zip
elisp-ja.epub: $(TEXIS)
	makeinfo --docbook elisp-ja.texi -o elisp-ja.docbook
	xsltproc http://docbook.sourceforge.net/release/xsl/current/epub/docbook.xsl elisp-ja.docbook
	echo "application/epub+zip" > mimetype
	zip -0Xq elisp-ja.epub mimetype
	zip -Xr9D elisp-ja.epub META-INF OEBPS

# EXPERIMENTAL
# REQUIRES: tesinfo-js
#           (in texinfo distribution's js/ subdir)
elisp-ja-html/index.html: $(TEXIS)
	texinfo-js elisp-ja.texi
