Running stateless
=================

Problem
-------

You want to force you application to be stateless at the HTTP level.

Solution
--------

In `Boot.scala`:

```scala
LiftRules.enableContainerSessions = false
LiftRules.statelessReqTest.append { case _ => true }
```

All requests will now be treated as stateless. Any attempt to use state, such as via `SessionVar` for example, will trigger a warning in developer mode: Access to Lift's statefull features from Stateless mode.  The operation on state will not complete. 

Discussion
----------

HTTP session creation is controlled via `enableContainerSessions`, and applies for all requests.  Leaving this value at the default (`true`) allows more fine-grained control over which requests are stateless.

Using `statelessReqTest` allows you to decide based on the `StatelessReqTest` if it should be stateless (`true`) or not (`false`).  For example:

```scala
def asset(file: String) = 
  List(".js", ".gif", ".css").exists(file.endsWith)

LiftRules.statelessReqTest.append { 
  case StatelessReqTest("index" :: Nil, httpReq) =>  true
  case StatelessReqTest(List(_, file),  _) if asset(file) => true
}
```

This example would only make the index page and any GIFs, JavaScript and CSS files stateless.  The `httpReq` part is a `HTTPRequest` instance, allowing you to base the decision on the content of the request (cookies, user agent, etc).

Another option is `LiftRules.statelessDispatch` which allows you to register a function which returns a `LiftResponse`.  This will be executed without a session, and convenient for REST-based services.


See Also
--------

* [Announcement of enhanced stateless support](http://groups.google.com/group/liftweb/browse_thread/thread/dab54c0a75a9a52a)
* [Wiki page on Stateless requests](http://www.assembla.com/wiki/show/liftweb/Stateless_Requests)
* [HTTP and REST](http://simply.liftweb.net/index-5.3.html#toc-Section-5.3) in _Simply Lift_.


