One time:

    brew install asciidoc
    easy_install pygments

    cp -r images/* ~/Desktop/cookbook.liftweb.net/src/main/webapp/images/

	asciidoc  -b html5 -a source-highlighter=pygments  -a toc2 --theme=flask -o ../lift-cookbook/index.html web.asciidoc

