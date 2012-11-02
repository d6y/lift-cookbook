Accessing HttpServletRequest
============================

Problem
-------

To satisfy some API you need access to the `HttpServletRequest`.

Solution
--------

Cast `S.request`:

```scala
import net.liftweb.http.S
import net.liftweb.http.provider.servlet.HTTPRequestServlet
import javax.servlet.http.HttpServletRequest

val servletRequest: Box[HttpServletRequest] = for {
  req <- S.request
  inner <- Box.asA[HTTPRequestServlet](req.request)
} yield inner.req
```

You can then make your API call:

```scala
servletRequest.foreach { r => yourApiCall(r) }
```

Discussion
----------

Note that the results is a `Box` because there might not be a request when you evaluate `servletRequest` -- or you might one day port to a different deployment environment and not be running on a standard Java servlet container.

As your code will have a direct dependency on the Java Servlet API, you'll need to include this dependency in your SBT build:

    "javax.servlet" % "servlet-api" % "2.5" % "provided->default"

See Also
--------

* Mailing list question regarding [HttpRequest conversion](https://groups.google.com/forum/?fromgroups#!topic/liftweb/67tQXSY9XS4).
