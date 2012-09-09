Viewing the lift_proto H2 database
===================================

Problem
-------

You're developing using the default `lift_proto.db` H2 database, and you'd like use a tool to look at the tables.


Solution
---------

Use the web interface included as part of H2, as documented in the first _See Also_ link.  
Here are the steps:

* Locate the H2 JAR file.  For me, this was: `~/.ivy2/cache/com.h2database/h2/jars/h2-1.2.147.jar`.
* Start the server from a terminal window using the JAR file you found: `java -cp /path/to/h2-version.jar org.h2.tools.Server`
* This should launch your web browser, asking you to login.
* Select "Generic H2 Server" in "Saved Settings".
* Enter `jdbc:h2:/path/to/youapp/lift_proto.db;AUTO_SERVER=TRUE` for "JDBC URL", adjusting the path for the location of your database, and adjusting the name of the database ("lift_proto.db") if different in your `Boot.scala`.
* Press "Connect" to view and edit your database.

Discussion
----------

Using the connection information given here and in the links below, you should be able to configure other SQL tools to access the database.


See also
--------
* [H2 web console and Lift](https://fmpwizard.telegr.am/blog/lift-and-h2) from @fmpwizard.
* [Viewing/Editing H2 database via web interface](http://sofoklis.posterous.com/viewingediting-h2-database-via-web-interface) blog post.
* [Default username/password for lift_proto.db](https://groups.google.com/forum/?fromgroups#!topic/liftweb/Gna1OTha-MI) mailing list discussion.
* Mailing list discussion on [Easiest way to set up H2 database with web console at localhost:8080/console](https://groups.google.com/forum/?fromgroups#!topic/liftweb/4Tvfu9859e0).
* H2's [tutorial page](http://www.h2database.com/html/tutorial.html).

