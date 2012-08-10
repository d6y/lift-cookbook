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

