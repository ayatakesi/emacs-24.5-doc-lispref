html:	elisp.html

%.texi : %.texi.po
	po4a-translate -f texinfo -k 0 -M utf8 -m $@.orig -p $@.po -l $@; 

elisp.html :  functions.texi.po macros.texi.po customize.texi
	texi2any --set-customization-variable TEXI2HTML=1 elisp.texi

