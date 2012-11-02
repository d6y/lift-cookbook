Debugging a request
===================

Problem
-------

You want to debug a request and see what's arriving to your Lift app.

Solution
--------

Add an `onBeginServicing` function in `Boot.scala` to log the request.  For example:

```scala
LiftRules.onBeginServicing.append {
  case r => println("Received: "+r)
}
```

Discussion
----------

The `onBeginServicing` call is called early in the Lift pipeline, before `S` is set up, and before Lift has the chance to 404 your request. The function signature it expects is `Req => Unit`.

If you want to select only certain paths, you can. For example, to track all requests starting `/paypal`:

```scala
LiftRules.onBeginServicing.append {
  case r @ Req(List("paypal", _), _, _) => println(r)
}
```

There is also an `onEndServicing` which can be given functions of type `(Req, Box[LiftResponse]) => Unit`.

See Also
--------

* Source code for [LiftRules.scala](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/http/LiftRules.scala).
* [Req.scala](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/http/Req.scala) source.
* Mailing list discussion on [What's the difference between LiftRules.early and LiftRules.onBeginServicing and when does S.locale get initialized?](https://groups.google.com/forum/?fromgroups#!topic/liftweb/K0S1rU0qtX0)

