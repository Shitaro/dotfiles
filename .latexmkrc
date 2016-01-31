# ~/.latexmkrc
$latex='platex --shell-escape -kanji=utf8 -guess-input-enc -synctex=1 -interaction=nonstopmode %S';
$dvipdf='dvipdfmx -f ptex-ipaex.map %S';
$bibtex='pbibtex -kanji=utf8 %B';
