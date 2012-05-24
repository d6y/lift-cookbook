Run code when Lift shutsdown
============================

Problem
-------

You want to have some code executed when your Lift application is shutting down.

Solution
--------

Append to `LiftRules.unloadHooks`.

```scala
LiftRules.unloadHooks.append( () => println("Shutting down") )
```

Discussion
----------

You append functions of type `() => Unit` and these functions are run right at the end of the Lift handler, after sessions have been destroyed, Lift actors have been shutdown, and requests have finished being handled.  This is triggered, in the words of the Java servlet specification, "by the web container to indicate to a filter that it is being taken out of service".

See Also
--------

* The recipe showing how to [run tasks periodically](Run+tasks+periodically.html) includes an example of using a unload hook.
