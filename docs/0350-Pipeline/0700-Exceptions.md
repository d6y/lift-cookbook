Catch any exception
===================

Problem
-------

You want a wrapper around all requests to catch certain exceptions to redirect the user to an error page.

Solution
--------


```scala
LiftRules.exceptionHandler.prepend {
  case (runMode, request, exception) =>           

  	 now what?

}
```


Discussion
----------



See Also
--------

* [

