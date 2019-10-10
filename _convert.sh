#!/bin/sh

perl -i.bak -pe 's/^\@noindent.+$/\@noindent/' text.texi
perl -i.bak -pe 's/^\@noindent.+$/\@noindent/' display.texi
