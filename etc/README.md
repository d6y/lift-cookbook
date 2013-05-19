One time:

    brew install asciidoc
    easy_install pygments

    cp -r images/* ~/Desktop/cookbook.liftweb.net/src/main/webapp/images/
    cat etc/0*asciidoc [0-9]*asciidoc | asciidoc  -b html5 -a source-highlighter=pygments  -a toc2 --theme=flask - > ~/Desktop/cookbook.liftweb.net/src/main/webapp/index.html


