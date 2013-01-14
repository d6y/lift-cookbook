One time:

    brew install asciidoc
    brew install source-highlight

    cp -r images/* ~/Desktop/cookbook.liftweb.net/src/main/webapp/images/
    cat [0-9]*asciidoc | asciidoc  -b html5 -a toc2 --theme=flask - > ~/Desktop/cookbook.liftweb.net/src/main/webapp/index.html



    cat 00-Lift-Cookbook.asciidoc 01-Installing-and-Running.asciidoc 02-HTML.asciidoc 03-Forms.asciidoc 04-REST.asciidoc 05-JavaScript-Ajax-Comet.asciidoc 06-Pipline.asciidoc 07-Record-Squeryl.asciidoc 09-Record-Mongo.asciidoc 10-Around.asciidoc 11-Deployment.asciidoc 12-Contributing.asciidoc | asciidoc  -b html5 -a toc2 --theme=flask - > /tmp/o.html

