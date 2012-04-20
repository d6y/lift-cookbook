Fetching URLs
===============

Problem
-------

You want to fetch a URL from inside your Lift app.

Solution
--------

Use _Dispatch_, "a library for HTTP interaction, from asynchronous GETs to multi-part OAuth-enticated POSTs". Before you start, include the dependencies in your `build.sbt` file:

```scala
libraryDependencies ++= Seq(
 "net.databinder" %% "dispatch-core" % "0.8.8",
 "net.databinder" %% "dispatch-http" % "0.8.8",
 "net.databinder" %% "dispatch-tagsoup" % "0.8.8"
)
```

Databinder is structured into a set of modules (e.g., for oAuth and Twitter). Above we're including a set for an example of fetching a URL and extracting all the meta tags:

```scala
import scala.xml.NodeSeq
import dispatch._
import dispatch.tagsoup.TagSoupHttp._

val page = url("http://www.w3.org/")

def metas(ns: NodeSeq) = ns \\ "meta"

val result: NodeSeq = Http(page </> metas)
```

The above produces:

```scala
NodeSeq(<meta content="text/html; charset=utf-8" http-equiv="Content-Type"></meta>, 
 <meta content="width=device-width" name="viewport"></meta>,
 <meta content="The World Wide Web Consortium (W3C) is an international community where 
  Member organizations, a full-time staff, and the public work together to develop Web 
  standards." name="description"></meta>)
```

Discussion
----------

As URL fetching has latency, you will want to look at making the request from an actor, a lazy-load snippet, via the various Dispatch executors or similar mechanism.

_Dispatch_ offers a range of operators in addition to the `</>` XML one used above.  You can extract text, JSON, consume the stream, or throw away the content.  The _Periodic table_ gives a great high-level view of what's available.

See Also
--------

* [Dispatch](http://dispatch.databinder.net/Dispatch.html).
* [Periodic table of Dispatch operators](http://www.flotsam.nl/dispatch-periodic-table.html).



