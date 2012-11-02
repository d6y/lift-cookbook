Run a task later
================

Problem
-------

You want to schedule code to run later.


Solution
--------

Use `net.liftweb.util.Schedule`:

```scala
Schedule( () => println("doing it"), 30 seconds)
```

This would cause "doing it" to be printed on the console after 30 seconds.

Discussion
----------

`Schedule` also includes a `schedule` method which will send a specified actor a specified message after a given delay.  

The above example makes use of the Lift `TimeHelpers`, but there are variant calls that accept `Long` millisecond values. 

Schedule returns a `ScheduledFuture[Unit]` from the Java concurrency library, which allows you to `cancel` the activity.

See Also
--------

* [Schedule.scala](https://github.com/lift/framework/blob/master/core/util/src/main/scala/net/liftweb/util/Schedule.scala) source.
* [java.util.concurrent.ScheduledFuture](http://docs.oracle.com/javase/6/docs/api/java/util/concurrent/ScheduledFuture.html) JavaDoc.
* Recipe for [Running tasks periodically](Run+tasks+periodically.html)



