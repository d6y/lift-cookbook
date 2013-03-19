#!/bin/sh
cd ..
for FILE in ` ls -ln  *.asciidoc | awk -F"." '{print $1}' | awk -F " " '{print $9}'`
do
	echo $FILE
	asciidoc  -b html5 -a source-highlighter=pygments  -a toc2 --theme=flask -o ../cookbook/$FILE.html $FILE.asciidoc
done




