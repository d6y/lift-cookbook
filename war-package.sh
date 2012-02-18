# Packages Pamflet output into just good enough WAR for deployment
# For use after: sbf write-pamflet
echo "<jsp:forward page='Lift+Cookbook.html'/>" > target/docs/index.jsp
echo "#`date`" >> target/pamflet.manifest
rm -f target/docs.war
jar cf target/docs.war -C target/docs .
