Logging SQL
===========

Problem
-------

You want to see the SQL being executed by Record with Squeryl.


Solution
--------

Add the following anytime you have a Squeryl season, such as just before your query:

```scala
org.squeryl.Session.currentSession.setLogger( s => println(s) )
```

By providing a `String => Unit` function to `setLogger`, Squeryl will execute that function with the SQL it runs. In this example, we are simply printing the SQL to the console.


Discussion
----------

This recipe is not specific to Lift, and will work wherever you use Squeryl.

See Also
--------
* Squeryl [getting started](http://squeryl.org/getting-started.html) page.
* Squeryl page on [logging the generated SQL](http://squeryl.org/miscellaneous.html)


