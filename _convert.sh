#!/bin/sh

# Locale/Po4a/Texi.pmのtranslate_line_commandで
# 対応できそうだが、対応されたらされたで過去po
# への影響確認とか面倒臭い
perl -i.bak -pe 's/^\@noindent.+$/\@noindent/' text.texi

perl -i.bak -pe 's/^\@noindent.+$/\@noindent/' display.texi
