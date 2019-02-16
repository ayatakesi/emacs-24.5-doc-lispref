html:	elisp.html

%.texi : %.texi.po
	po4a-translate -f texinfo -k 0 -M utf8 -m $@.orig -p $@.po -l $@; 

elisp.html :  control.texi functions.texi lists.texi objects.texi symbols.texi customize.texi hash.texi macros.texi sequences.texi variables.texi eval.texi intro.texi numbers.texi strings.texi loading.texi compile.texi debugging.texi edebug.texi streams.texi minibuf.texi commands.texi keymaps.texi modes.texi help.texi files.texi backups.texi buffers.texi windows.texi frames.texi positions.texi markers.texi text.texi nonascii.texi searching.texi syntax.texi abbrevs.texi
	./_convert.sh
	texi2any --set-customization-variable TEXI2HTML=1 elisp.texi && \
        cp -f elisp.html ~/storage/shared/Documents

elisp_html/index.html : control.texi functions.texi lists.texi objects.texi symbols.texi customize.texi hash.texi macros.texi sequences.texi variables.texi eval.texi intro.texi numbers.texi strings.texi loading.texi compile.texi debugging.texi edebug.texi streams.texi minibuf.texi commands.texi keymaps.texi modes.texi help.texi files.texi backups.texi buffers.texi windows.texi frames.texi positions.texi markers.texi text.texi nonascii.texi searching.texi syntax.texi abbrevs.texi
	./_convert.sh
	makeinfo -o elisp_html/ --html elisp.texi && \
	tar cvfz elisp_html.tar.gz ./elisp_html && \
	mv -f elisp_html.tar.gz ~/storage/downloads && \
	cd ~/storage/downloads && \
        tar xvfz elisp_html.tar.gz

