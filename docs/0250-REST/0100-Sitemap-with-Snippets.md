Sitemap with Snippets
====================================

Problem
-------

You want to make a Sitemap (e.g. for Google) using Lift's rendering capabilities.

Solution
--------

Simply create a file (e.g. sitemap.html) in your webapp/-folder with a valid XML-Sitemap markup.

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

Make a snippet to fill the required gaps.

```scala
class MySitemapContent {
  lazy val entries = MyDBRecord.find(..)

  def base: CssSel =
    "loc *" #>      "http://%s/".format(S.hostName) &
    "lastmod *" #>  someDate.toString("yyyy-MM-dd'T'HH:mm:ss.SSSZZ")

  def list: CssSel =
    "url *" #> entries.map(post =>
      "loc *" #>      "http://%s/".format(S.hostName, post.url) &
      "lastmod *" #>  post.date.toString("yyyy-MM-dd'T'HH:mm:ss.SSSZZ"))

}
```

We could run this template through Lift's default HTML render engine and simply add it to Lift's own Sitemap, but we want our valid XML to be delivered as XML rather than HTML.

```scala
import net.liftweb.http.rest._
import net.liftweb.http._

object MySitemap extends RestHelper {
  serve {
    case Req("sitemap" :: Nil, _, GetRequest) =>
      XmlResponse(S.render(<lift:embed what="sitemap" />, S.request.get.request).head)
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
<?xml version="1.0" encoding="UTF-8"?>
<b>got an image of 43685 bytes</b> 
```



