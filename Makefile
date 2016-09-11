html:	elisp.html

functions.texi : functions.texi.po
	po4a-translate -f texinfo -k 0 -M utf8 -m $@.orig -p $@.po -l $@; 

macros.texi : macros.texi.po
	po4a-translate -f texinfo -k 0 -M utf8 -m $@.orig -p $@.po -l $@; 

elisp.html :  functions.texi.po macros.texi.po
	texi2any --set-customization-variable TEXI2HTML=1 elisp.texi

