Running code when sessions are created (or destroyed)
=====================================================

Problem
-------

You want to carry out actions when a sesison is created or destroyed.

Solution
--------

Make use of the hooks in `LiftSession`.  For example, in `Boot.scala`:

```scala
LiftSession.afterSessionCreate ::= 
 ( (s:LiftSession, r:Req) => println("Session created, state available") )

LiftSession.onBeginServicing ::= 
 ( (s:LiftSession, r:Req) => println("Processing request") )

LiftSession.onShutdownSession ::= 
 ( (s:LiftSession) => println("Session going away") )
```

Discussion
----------

The hooks in `LiftSession` allow you to insert code at various points in the sessions lifecycle: when the session is created, at the start of servicing the request, after servicing, when the session is about to shutdown, at shutdown... check the source code link, below and the _Exploring Lift_ session pipeline diagrams and descriptions.

If the request path has been marked as being stateless via `LiftRules.statelessReqTest`, the above example would only execute the `onBeginServicing` functions.


------------- S.addAround?






See Also
--------

* [LiftSession source code](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/http/LiftSession.scala)
* [Example of logging a user out if the login via another browser](https://github.com/dpp/starting_point/commit/729f05f9010b80139440369c4e1d0889cac346cf)
* Chapter 15 of _Lift in Action_ gives an example of timing requests using `LiftSession`.
* [The request/response lifecycle](http://exploring.liftweb.net/master/index-9.html#toc-Section-9.2) in _Exploring Lift_, includes diagrams showing the steps a request passes through.
* [Wiki page on the HTTP Pipeline](http://www.assembla.com/spaces/liftweb/wiki/HTTP_Pipeline)
* [Session management](http://exploring.liftweb.net/master/index-9.html#toc-Section-9.5) in _Exploring Lift_.
