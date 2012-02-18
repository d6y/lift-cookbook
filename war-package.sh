# Packages Pamflet output into just good enough WAR for deployment
# For use after: sbf write-pamflet
cp docs/img/* target/docs/img/ 
echo "<jsp:forward page='Lift+Cookbook.html'/>" > target/docs/index.jsp
echo "" >> target/docs/pamflet.manifest
echo "#`date`" >> target/docs/pamflet.manifest
rm -f target/docs.war
jar cf target/docs.war -C target/docs .
