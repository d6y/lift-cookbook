One time:

    brew install asciidoc
    brew install source-highlight

    cp -r images/* ~/Desktop/cookbook.liftweb.net/src/main/webapp/images/
    cat [0-9]*asciidoc | asciidoc  -b html5 -a toc2 --theme=flask - > ~/Desktop/cookbook.liftweb.net/src/main/webapp/index.html




