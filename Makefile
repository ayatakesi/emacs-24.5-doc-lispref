html:	elisp.html

%.texi : %.texi.po
	po4a-translate -f texinfo -k 0 -M utf8 -m $@.orig -p $@.po -l $@; 

elisp.html :  control.texi functions.texi lists.texi objects.texi symbols.texi customize.texi hash.texi macros.texi sequences.texi variables.texi eval.texi intro.texi numbers.texi strings.texi loading.texi compile.texi debugging.texi edebug.texi streams.texi minibuf.texi commands.texi keymaps.texi
	texi2any --set-customization-variable TEXI2HTML=1 elisp.texi && \
        cp -f elisp.html ~/storage/shared/Documents

elisp_html/index.html : elisp.html
	makeinfo -o elisp_html/ --html elisp.texi && \
        cp -fr elisp_html ~/storage/shared/Documents
