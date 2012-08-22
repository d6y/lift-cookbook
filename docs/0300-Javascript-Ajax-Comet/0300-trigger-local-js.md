Set up client-side actions from your Scala code
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
* [Chapter 10](http://exploring.liftweb.net/master/index-10.html#toc-Chapter-10) of _Exploring Lift_.