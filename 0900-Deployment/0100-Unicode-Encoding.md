MySQL unicode charset encoding
===============================

Problem
-------

Some characters stored in your MySQL database are appearing as `???`.

Solution
--------

Ensure:

* `Boot.scala` includes: `LiftRules.early.append(_.setCharacterEncoding("UTF-8"))`
* Your JDBC connections URL includes `?useUnicode=true&characterEncoding=UTF-8`
* Your MySQL database has been created using a UTF-8 character set.


See Also
--------

* [EMail thread on the Lift mailing list](https://groups.google.com/forum/?fromgroups#!topic/liftweb/DL9AFyU5y2k)
* [MySQL UTF-8 test Lift app](https://github.com/d6y/mysql-lift-charset-test) - although it uses SBT 0.7 so is rather out of date.
* [MySQL JDBC COnfiguration reference](http://dev.mysql.com/doc/refman/5.6/en/connector-j-reference-configuration-properties.html)
