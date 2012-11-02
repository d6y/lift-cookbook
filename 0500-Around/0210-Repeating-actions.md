Run tasks periodically
======================

Problem
-------

You want a scheduled task to run periodically.


Solution
--------

Use `net.liftweb.util.Schedule` ensuring that you call `schedule` again during your task to re-schedule it. For example:

```scala
import net.liftweb.util.Schedule
import net.liftweb.actor.LiftActor
import net.liftweb.util.Helpers._

object MyScheduledTask extends LiftActor {
  
  case class DoIt()
  case class Stop()
  
  private var stopped = false
  
   def messageHandler = {  
     case DoIt => 
       if (!stopped) 
       	Schedule.schedule(this, DoIt, 10 minutes)
       // ... do useful work here
     
     case Stop =>
       stopped = true
   }
}
```

The example creates a `LiftActor` for the work to be done. On receipt of a `DoIt` message, the actor re-schedules itself before doing whatever useful work needs to be done.  In this way, the actor will be called every 10 minutes.

The `Schedule.schedule` call is ensuring that `this` actor is sent the `DoIt` message after 10 minutes.  

To start this process off, possibly in `Boot.scala`, just send the `DoIt` message to the actor.

To ensure the process stops correctly when Lift shuts down, we register a shutdown hook in `Boot.scala` to send the `Stop` message to prevent future re-schedules:

```scala
LiftRules.unloadHooks.append( () => MyScheduledTask ! MyScheduledTask.Stop )
```

Discussion
----------

Without the `Stop` message your actor would continue to be rescheduled until the JVM exits. This may be acceptable, but note that during development with SBT, without the `Stop` message, you will continue to schedule tasks after issuing the `container:stop` command.

Schedule returns a `ScheduledFuture[Unit]` from the Java concurrency library, which allows you to `cancel` the activity.

See Also
--------

* [Schedule.scala](https://github.com/lift/framework/blob/master/core/util/src/main/scala/net/liftweb/util/Schedule.scala) source.
* [java.util.concurrent.ScheduledFuture](http://docs.oracle.com/javase/6/docs/api/java/util/concurrent/ScheduledFuture.html) JavaDoc.
* Chapter 1 of _Lift in Action_ includes a CometActor clock example that uses `Schedule`, and further examples can be found in chapters 4 and 9.



