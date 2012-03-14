Deploying to CloudBees
=======================

Problem
-------

You have an account with the CloudBees PaaS hosting environment, and you want to deploy your Lift application there.


Solution
--------

Use the SBT `package` command to produce a WAR file that can be deployed to CloudBees, and then use the SDK to configure and deploy your application. 

For best performance you will want to ensure the Lift run mode is set to "production".  Do this from the CloudBees SDK command line:

```scala
\$ bees config:set -a myaccount/myapp run.mode=production
```
  
This will set the run mode to production for your CloudBees applications identified as ""myaccount/myapp".  Omitting the `-a` will set it for your whole CloudBees account.  

CloudBees will remember this setting, so you only need to do it once.

You can then deploy:

```scala
\$ sbt package
...
[info] Packaging /Users/richard/myapp/target/scala-2.9.1/myapp.war...
...
\$ bees app:deploy ./target/scala-2.9.1/myapp.war
```

Discussion
----------

You may find it more convenient to install the SBT CloudBees plugin to deploy directly from SBT.  "See Also" provides a link to this plugin and the excellent instructions for installing and configuring it.

If you are deploying a single application to multiple CloudBees instances, be aware that by default CloudBees will round robin requests to each instance. If you use any of Lift's state features you'll want to enable session affinity (sticky sessions).

If you are using a database in your application, you may find it useful to configure this in `src/main/webapp/WEB-INF/cloudbees-web.xml`. For example:

```scala
<?xml version="1.0"?>
<cloudbees-web-app xmlns="http://www.cloudbees.com/xml/webapp/1">

<appid>myaccount/myapp</appid>

<resource name="jdbc/mydb" auth="Container" type="javax.sql.DataSource">  
  <param name="username" value="dbuser" />
  <param name="password" value="dbpassword" />
  <param name="url" value="jdbc:cloudbees://mydb" />

  <!-- Connection Pool settings: 
   http://commons.apache.org/dbcp/configuration.html 
   -->
  <param name="maxActive" value="10" />
  <param name="maxIdle" value="2" />
  <param name="maxWait" value="15000" />
  <param name="removeAbandoned" value="true" />
  <param name="removeAbandonedTimeout" value="300" />
  <param name="logAbandoned" value="true" />

  <!-- Avoid idle timeouts -->
  <param name="validationQuery" value="SELECT 1" />
  <param name="testOnBorrow" value="true" />
 
 </resource>

</cloudbees-web-app>
```

The above is a JNDI database configuration, defining a connection to a CloudBees database called "mydb". This will be used by Lift if the JNDI name is referenced in `Boot.scala`:

```scala
DefaultConnectionIdentifier.jndiName = "jdbc/mydb"
    
if (!DB.jndiJdbcConnAvailable_?) {
  // set up alternative local database connection here      
}
```

Because the JDNI setting is only defined in `cloudbees-web.xml` it will only be available in a CloudBees environment. This means you can develop against a different database locally, and use your CloudBees database when deploying.


See Also
--------

* [CloudBees SDK](http://wiki.cloudbees.com/bin/view/RUN/BeesSDK)
* [SBT Cloudbees plugin](https://github.com/timperrett/sbt-cloudbees-plugin).
* [CloudBees Session Affinity](http://wiki.cloudbees.com/bin/view/RUN/Session+Affinity)
* As an alternative to `bees:config`, you can [set run.mode via a filter](https://github.com/d6y/cloudbees-lift-filter)



