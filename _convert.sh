#!/bin/sh

if [ -f text-ja.texi ];
then
    perl -i.bak -pe 's/^\@noindent.+$/\@noindent/' text-ja.texi;
fi

if [ -f display-ja.texi ];
then
    perl -i.bak -pe 's/^\@noindent.+$/\@noindent/' display-ja.texi;
fi

