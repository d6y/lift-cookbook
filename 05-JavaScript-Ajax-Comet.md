Javascript, Ajax, Comet
=======================





Trigger server-side code from a button press
=============================

Problem
-------

You want to trigger some server-side code when the user presses a button.

Solution
--------

Use `ajaxInvoke`: 


```scala
import net.liftweb.util.Helpers._
import net.liftweb.http.SHtml
import net.liftweb.http.js.JsCmds

class MySnippet {
  
 def easy = "#myButton [onclick]" #> SHtml.ajaxInvoke( () => {
    println("click")
    JsCmds.Alert("Hi")
    } )
}
```

In this snippet we are binding the click event of a button with the id of "myButton" to an `ajaxInvoke`:  when the button is pressed, Lift arranges for the function you gave `ajaxInvoke` to be executed.

In this example, we are printing "click" to the console and returning a JavaScript alert dialog. The corresponding HTML might be:

```html
<div class="lift:MySnippet.easy">
  <button id="myButton">Click me</button>
</div>
```


Discussion
----------

The signature of the function you pass to `ajaxInvoke` is `Unit => JsCmd`, meaning you can trigger a range of behaviours, from returning `Noop` if you want nothing to happen, through changing DOM element, all the way up to executing arbitrary JavaScript.

The example above is using a button, but will work on any element that has an event you can bind to.

Related to `ajaxInvoke` are the following functions:

* `SHtml.onEvent`, which has the signature `String => JsCmd` because it is passed the `value` of the node it is attached to.  In the above example, this would be the empty string as the button has no value.

* `SHtml.ajaxCall` which is more general than `onEvent`, as you give it the expression you want passed to your server-side code.

* `SHtml.jsonCall` which is even more general: you give it a function that will return a JSON object when executed on the client, and this object will be passed to your server-side function. 


See Also
--------

* The "[Call Scala code from JavaScript](http://blog.fmpwizard.com/scala-lift-custom-wizard)" section of a blog post from Diego Medina.
* [AJAX and Comment in Lift](http://exploring.liftweb.net/onepage/index.html#toc-Section-11) in _Exploring Lift_.
* Chapter 9 of _Lift in Action_.
* _Simply Lift_ on [Ajax](http://simply.liftweb.net/index-4.8.html#toc-Section-4.8).
* Mailing list discussion on the [easiest way to trigger server-side Scala code](https://groups.google.com/forum/?fromgroups#!topic/liftweb/N7ttFlumvuk).
* [Bind a button click with SHtml.onEvent](https://groups.google.com/forum/?fromgroups#!topic/liftweb/uAgy21xOMRs) mailing list thread.
* [SHtml.scala](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/http/SHtml.scala) source code.Set up client-side actions from your Scala code
=============================

Problem
-------

In your Lift code you want to set up a action that is run purely in client-side JavaScript. 


Solution
--------

Bind the appropriate event hander with Javascript. Here's an example where we make a button slowly fade away when you press it, but notice that we're setting up this binding in our server-side Lift code:

```scala
class HelloWorld {
  def buttonBind = 
    "#button [onclick]" #> "\$('#button').fadeOut('slow')"
}
```

In the template we'd perhaps say:

```html
<form class="lift:HelloWorld.buttonBind">
  <input id="button" type="button" value="Click me" />
</form>
```

Lift will render the page as:

```html
<form>
  <input onclick="\$('#button').fadeOut('slow')" 
    value="Click me" type="button" id="button">
</form>
```

Discussion
----------

Lift includes a JavaScript abstraction which you can use to build up more elaborate expressions for the client-side. For example you can combine basic commands:

```scala
def buttonBind = 
  "#button [onclick]" #> (
     Alert("Here we go...") & RedirectTo("http://liftweb.net")
    ).toJsCmd
```

...which pops up an alert dialog and then sends you to liftweb.net. _Exploring Lift_ gives a good summary of the commands available to you.

Another option is to use `JE.Call` to execute a Javascript function with parameters. Suppose we have this function defined:

```javascript
function greet(who) {
  alert("Hello "+who)
}
```

We could bind a client-side button press to this client-side function like this:

```scala
def buttonBind = 
  "#button [onclick]" #> JE.Call("greet", "you").toJsCmd
```

See Also
--------

* The [mailing list discussion](https://groups.google.com/d/msg/liftweb/uAgy21xOMRs/bDjS69VWpp4J) that suggested this.
* [Chapter 10](http://exploring.liftweb.net/master/index-10.html#toc-Chapter-10) of _Exploring Lift_.Focus on a field on page load
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


Add CSS class to an Ajax Form
=============================

Problem
-------

You want to set the CSS class of an AJAX form.

Solution
--------

Name the class via `?class=` query parameter:

```html
<form class="lift:form.ajax?class=myClass">
...
</form>
```

Discussion
----------

If you need to set multiple CSS classes, encode a space between the class names, e.g., `class=myClass%20anotherClass`.


See Also
--------

* _Simply Lift_ on [Ajax](http://simply.liftweb.net/index-4.8.html).
* Mailing list on [Attaching CSS class to ajax form using designer friendly template doesn't work](https://groups.google.com/forum/?fromgroups#!topic/liftweb/EEINT9t8Wd4).


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


