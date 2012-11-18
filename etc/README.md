
brew install asciidoc
brew install source-highlight

cat *asciidoc | asciidoc -b html5 -a toc2 --theme=flask - > out.html



