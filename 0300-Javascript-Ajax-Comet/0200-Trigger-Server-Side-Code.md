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
* [SHtml.scala](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/http/SHtml.scala) source code.