REST
====



DRY URLs
========

Problem
-------

You found yourself repeating parts of URL paths in your RestHelper, and you Don't want to Repeat Yourself.

Solution
--------

Use `prefix` in your RestHelper:

```scala
object RestAPI extends RestHelper {

  serve("bugs" / "by-state" prefix {
    case "open" :: Nil JsonGet _ => <p>None open</p>
    case "closed" :: Nil JsonGet _ => <p>None closed</p>
    case state :: Nil JsonDelete _ => <p>All deleted</p>
  })

}
```


Discussion
----------

You can have many `serve` blocks in your `RestHelper`, which helps give your REST service structure.


See Also
--------

* [RestHelper](http://simply.liftweb.net/index-5.3.html), section 5.3 of _Simply Lift_.
* Wiki page on [REST Web Services](http://www.assembla.com/spaces/liftweb/wiki/REST_Web_Services).



Google Sitemap
====================================

Problem
-------

You want to make a Google Sitemap using Lift's rendering capabilities.

Solution
--------

Simply create a file (e.g. `sitemap.html`) in your `webapp` folder with a valid XML-Sitemap markup:

```
<?xml version="1.0" encoding="utf-8" ?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
<lift:MySitemapContent.base>
	<url>
		<loc></loc>
		<changefreq>daily</changefreq>
		<priority>1.0</priority>
		<lastmod></lastmod>
	</url>
</lift:MySitemapContent.base>
<lift:MySitemapContent.list>
	<url>
		<loc></loc>
		<lastmod></lastmod>
	</url>
</lift:MySitemapContent.list>
</urlset>
```

Make a snippet to fill the required gaps:

```scala
class MySitemapContent {

  lazy val entries = MyDBRecord.findAll(..)

  def base: CssSel =
    "loc *" #> "http://%s/".format(S.hostName) &
    "lastmod *" #> someDate.toString("yyyy-MM-dd'T'HH:mm:ss.SSSZZ")

  def list: CssSel =
    "url *" #> entries.map(post =>
      "loc *" #> "http://%s%s".format(S.hostName, post.url) &
      "lastmod *" #>  post.date.toString("yyyy-MM-dd'T'HH:mm:ss.SSSZZ"))

}
```
Note that Google Sitemaps need dates to be in ISO 8601 format. The built-in `java.text.SimpleDateFormat` does not support this format prior to Java 7.
If you are using Java 6 you need to use `org.joda.time.DateTime`. With Java 7 "yyyy-MM-dd'T'HH:mmXXX" can be used as the pattern for the formatting.

We could run this template through Lift's default HTML render engine and simply add it to Lift's own Sitemap, but we want our valid XML to be delivered as XML rather than HTML.  So instead we will use `RestHelper` to return a `XmlResponse`:

```scala
import net.liftweb.http.rest._
import net.liftweb.http._

object MySitemap extends RestHelper {
  serve {
    case Req("sitemap" :: Nil, _, GetRequest) =>
      XmlResponse(S.render(<lift:embed what="sitemap" />, 
       S.request.get.request).head)
    }
  }
}
```

Wire this into your application in `Boot.scala`, for example:

```scala
LiftRules.statelessDispatchTable.append(code.lib.MySitemap) 
```

Test this service using a tool like cURL:

```scala
\$ curl http://127.0.0.1:8080/sitemap
```


See Also
--------

* [About Google Sitemaps](http://support.google.com/webmasters/bin/answer.py?hl=en&answer=156184).

Missing file suffix
===================

Problem
-------

Your RestHelper expects a filename as part of the URL, but the suffix (extension) is missing, and you need it.

Solution
--------

Access `req.path.suffix` to recover the suffix.  For example, when processing `/download/123.png` you want to be able reconstruct `123.png`:

```scala
private def reunite(name: String, suffix: String) =
  if (suffix.isEmpty) name else name+"."+suffix

serve {
  case "download" :: name :: Nil Get req => 
    Text("You requested "+reunite(name, req.path.suffix))
}
```

Requesting this URL with a command like cURL will show you the filename as expected:

```
\$ curl http://127.0.0.1:8080/download/123.png
<?xml version="1.0" encoding="UTF-8"?>
You requested 123.png  
```

Discussion
----------

When Lift parses a request it splits the request into constituent parts (e.g., turning the path into a `List[String]`), and this includes a separation of some suffixes.  This is great for pattern matching when you want to change behaviour based on the suffix, but a hinderance in this particular situation.

Only those suffixes defined in `LiftRules.explicitlyParsedSuffixes` are split from the filename. This includes many of the common file suffixes (such as "png", "atom", "json") and also some you may not be so familiar with, such as "com".  That last one is the cause of URLs that contain email addresses being split from "user@example.org" into  "user@example" and a suffix of "com".

You can modify `LiftRules.explicitlyParsedSuffixes` to be whatever set of values you want.

Note that if the suffix is not in `explicitlyParsedSuffixes`, the suffix will be an empty String and the `name` (in the above example) will be the file name with the suffix still attached. 


See Also
--------

* Source for [HttpHelpers.scala](https://github.com/lift/framework/blob/master/core/util/src/main/scala/net/liftweb/util/HttpHelpers.scala) where you can find the default list of known suffixes.
* Mailing list discussion [RestHelper GET strips off .com when GETting email as parameter with .com address](https://groups.google.com/forum/?fromgroups#!topic/liftweb/zj8kazJPzmI).
* [REST helper: how to get file extension](https://groups.google.com/forum/?fromgroups#!topic/liftweb/h5-LdtRDfiw) mailing list discussion.


Failing to match on a file suffix
=================================

Problem
-------

You're trying to match on a file suffix (extension), but your match is failing.

Solution
--------

Ensure the suffix you're matching on is included in `LiftRules.explicitlyParsedSuffixes`.

As an example, perhaps you want to match anything ending in `.csv` at your `/reports/` URL:

```scala
case Req("reports" :: name :: Nil, "csv", GetRequest) =>
  Text("Here's your CSV report for "+name)
```

You're expecting `/reports/foo.csv` to produce "Here's your CSV report for foo", but you get a 404.

In `Boot.scala` add the following:

```scala
LiftRules.explicitlyParsedSuffixes += "csv"
```

Discussion
----------

This is the flip side of the _Missing file suffix_ recipe: Lift only splits out the suffixes it knows about in `LiftRules.explicitlyParsedSuffixes`.

Without adding ".csv" to the `explicitlyParsedSuffixes`, the example URL would match with...

```scala
case Req("reports" :: name :: Nil, "", GetRequest) => ... 
```

...with `name` set to "foo.csv" not "foo".


See Also
--------

* [Missing file suffix](Missing+file+suffix.html) recipe.
* [REST Requst suffix matching](https://groups.google.com/d/topic/liftweb/UwZQ8f2MmLE/discussion) mailing list discussion.
* [REST the hard way](http://simply.liftweb.net/index-5.2.html), section 5.2 of _Simply Lift_.
* [Making it easier with RestHelper](http://simply.liftweb.net/index-5.3.html), section 5.3 of _Simply Lift_.

Accept binary data in a REST service
====================================

Problem
-------

You want to accept an image upload or other binary data in your RESTful service.

Solution
--------

Access the request body in your rest helper:

```scala
import net.liftweb.http.rest._
import net.liftweb.http._

object MyUpload extends RestHelper {
  serve {
    case "upload" :: Nil Post req => 
      for {
        bodyBytes <- req.body ?~ "No Body Bytes"
      } yield <b>got an image of {bodyBytes.length} bytes</b>
  }
}
```

Wire this into your application in `Boot.scala`, for example:

```scala
LiftRules.statelessDispatchTable.append(code.lib.MyUpload) 
```

Test this service using a tool like cURL:

```scala
\$ curl -X POST --data-binary "@dog.jpg" \
  -H 'Content-Type: image/jpg' http://127.0.0.1:8080/upload
<?xml version="1.0" encoding="UTF-8"?>
<b>got an image of 43685 bytes</b> 
```

Discussion
----------

In the above example the binary data is accessed via the `req.body`, yielding a `Box[LiftResponse]` which in this case is XML.

In the case where there is no body, a 404 would be returned with a text body of "No Body Bytes".

Note that web containers, such as Jetty and Tomcat, may place limits on the size of an upload.  You will recognise this situation by an error such as "java.lang.IllegalStateException: Form too large705784>200000".  Check with documentation for the container for changing these limits.


See Also
--------

* [Mailing list discussion](https://groups.google.com/forum/?fromgroups#!topic/liftweb/6MnWRPP3TcU) including code for restricting a request based on mime type.
* [Form too large in Jetty](http://stackoverflow.com/questions/3861455/form-too-large-exception)



Returning JSON
==============

Problem
-------

You want to return JSON from a REST call.

Solution
--------

Use the JSON DSL.  For example:

```scala
package code.lib

import net.liftweb.http.rest._
import net.liftweb.json.JObject
import net.liftweb.json.JsonDSL._

object QuotationAPI extends RestHelper {

 serve {
  case "quotation" :: Nil JsonGet _ => 
   ("text" -> "A beach house isn't just real estate. It's a state of mind.") ~ 
   ("by" -> "Douglas Adams") : JObject
 }

}
```

Wire this into `Boot.scala`:

```scala
LiftRules.statelessDispatch.append(code.lib.QuotationAPI)
```

Running this example produces:

```
\$ curl -H 'Content-type: text/json' http://127.0.0.1:8080/quotation
{
  "text":"A beach house isn't just real estate. It's a state of mind.",
  "by":"Douglas Adams"
}
```


Discussion
----------

The "type ascription" at the end of the JSON expression (`: JObject`) tells the compiler that the expression is expected to be of type `JObject`.  This is required to allow the DSL to work.  If would not be required if, for example, you were calling a function that was defined to return a `JObject`.

The JSON DSL allows you to created nested structures, lists and everything else you expect of JSON.  The _Readme_ in the _See Also_ section is a great place to read about the library.

See Also
--------

* The [Lift JSON Readme](https://github.com/lift/framework/tree/master/core/json) is a great source of documentation and examples of using the JSON package in Lift.



