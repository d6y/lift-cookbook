Focus on a field on page load
=============================

Problem
-------

When a page loads you want the browser to select a particular field for input focus from the user's keyboard.

Solution
--------

Wrap your snippet with `FocusOnLoad`:  

```scala
import net.liftweb.http.js.JsCmds._
...
"name=username" #> FocusOnLoad(SHtml.text(username, username = _))
```

The above will match against `name="username"` element in the HTML and replace it with a text input field that will be focused on automatically when the page loads.


Discussion
----------

`FocusOnLoad` is an example of a `NodeSeq => NodeSeq` transformation.  In this case, it takes the result of `SHtml.text` and appends it with the JavasScript required to set focus on that field. The example uses `SHtml.text` but it could be any `NodeSeq`.   

Related classes are:

* `Focus`, which takes an element id and sets focus on the element via a `JsCmd`. 
* `SetValueAndFocus` which is like `Focus` but takes an additional `String` value to set on the element.

These two are useful if you need to set focus from Ajax or Comet components, or any JavaScript Lift response.


See Also
--------

* [Lift and JavaScript](http://exploring.liftweb.net/master/index-10.html#toc-Chapter-10), _Exploring Lift_, chapter 10.
* [FocusOnLoad for fields you're creating in a snippet](http://groups.google.com/group/liftweb/browse_thread/thread/c513317f7b01b40a/a95a0426c7e17a46?lnk=gst&q=FocusOnLoad#)
* [FocusOnLoad in LiftScreen](http://groups.google.com/group/liftweb/browse_thread/thread/541e6f3a156ccc47/fc501899e7537290?lnk=gst&q=FocusOnLoad#fc501899e7537290)
* [How do I keep focus on a textbox?](http://stackoverflow.com/questions/3852122/how-do-i-keep-focus-on-a-textbox-using-lift-the-scala-framework)
* [JsCommands.scala source](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/http/js/JsCommands.scala)


