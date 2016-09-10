%.texi:
	po4a-translate -f texinfo -k 0 -M utf8 -m original_texis/$@ -p $@.po -l $@; \
	texi2any --set-customization-variable TEXI2HTML=1 $@

