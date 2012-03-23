Access restriction by HTTP header
=================================

Problem
-------

You need to control access to a page based on the value of a HTTP header.


Solution
--------

Use a custom `If` in SiteMap:

```scala
val HeaderRequired = If(  
  () => S.request.map(_.header("ALLOWED") == Full("YES")) openOr false,
  "Access not allowed" 
)

// Build SiteMap
val entries = List(
      Menu.i("Restricted") / "restricted" >> HeaderRequired
)
```

In this example  `restricted.html` can only be viewed if the request includes a HTTP header called `ALLOWED` with a value of `Yes`.  Any other request for the page will be redirected with a Lift error notice of "Access not allowed".

This can be tested from the command line using a tool like cURL:

```scala
\$ curl  http://127.0.0.1:8080/restricted.html -H "ALLOWED:YES"
```

Discussion
----------

The `If` test ensures the `() => Boolean` function you supply as a first argument returns `true` before the page it applies to is shown. The second argument is what Lift does if the test isn't true, and should be a `() => LiftResponse` function, meaning you can return whatever you like, including redirects to other pages.

In the example we are making use of a convenient implicit conversation from a `String` ("Access not allowed") to a redirection that will take the user to the home page (actually `LiftRules.siteMapFailRedirectLocation`) with a notice which shows the string.


See Also
--------

* Mailing list thread on [testing a Loc for a HTTP Header Value for Access Control](https://groups.google.com/forum/?fromgroups#!topic/liftweb/CtSGkPbgEVw).
* Source for [Loc.scala](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/sitemap/Loc.scala) where `If` and other tests are defined.
* Chapter 7, "SiteMap and access control" in _Lift in Action_.
* [Site map in _Exploring Lift_](http://exploring.liftweb.net/onepage/index.html#toc-Chapter-7).

----

Comments? Questions? Corrections? [Discuss this recipe on the Lift Web mailing list](mailto:liftweb@googlegroups.com?subject=Cookbook%20-%20Access%20restriction%20by%20HTTP%20header).
