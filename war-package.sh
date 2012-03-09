# Packages Pamflet output into just good enough WAR for deployment
# For use after: sbt clean write-pamflet
find  docs -name '*.jpg' -exec cp {} target/docs/img/ \; 
echo "<jsp:forward page='Lift+Cookbook.html'/>" > target/docs/index.jsp
echo "" >> target/docs/pamflet.manifest
echo "#`date`" >> target/docs/pamflet.manifest
# Ok, this is getting silly now. Append images to the html5 manifest
find target/docs/img -execdir echo {} >> ../pamflet.manifest \;
rm -f target/docs.war
jar cf target/docs.war -C target/docs .
