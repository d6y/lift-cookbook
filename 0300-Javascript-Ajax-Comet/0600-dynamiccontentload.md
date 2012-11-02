Show a template inside a page dynamically
=============================

Problem
-------

You want to load an entire page with template and snippets inside of another template on the fly (i.e., without a browser refresh).


Solution
--------

Use `Template` to load the template, and `SetHtml` to place the content on the page.  

```scala
package code.snippet 

import net.liftweb.util._
import Helpers._
import net.liftweb.http._
import js.JsCmds._

class MySnippet {

  def sendContent = Templates("some" :: "page" :: Nil).
    map(ns => SetHtml("here", ns)) openOr Noop

  def render = "name=clickme [onclick]" #> SHtml.ajaxInvoke(sendContent _)
}
```

Combine this with:

```html
<div class="lift:MySnippet">
  <button name="clickme">Click Me</button>
  <div id="here">Content will appear here</div>
</div>
```

Clicking the button will cause the content of `/some/page.html` to be loaded into the `here` div.


Discussion
----------

`Templates` produces a `Box[NodeSeq]`, the contents of which are mapped to a `JsCmd` which is sent back to the browser to put the contents of the page into the div. 


See Also
--------

* [SetHtml](http://scala-tools.org/mvnsites/liftweb-2.4/net/liftweb/http/js/JsCmds\$\$SetHtml.html) documentation.
* [Loading Pages With Templates from Other Pages](https://groups.google.com/forum/?fromgroups#!topic/liftweb/C5UhQn5blHk) mailing list discussion.


