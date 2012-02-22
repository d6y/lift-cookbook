Rendering Textile markup
========================

Problem
-------

You want to render Textile markup in your web app.

Solution
--------

Install the Lift Textile module in your `build.sbt` file by adding the following to the list of dependencies:

```scala
"net.liftweb" %% "lift-textile" % liftVersion % "compile->default", 
```
You can then render Textile using `toHtml` method:

```scala
scala> import net.liftweb.textile._                   
import net.liftweb.textile._

scala> TextileParser.toHtml("""h1. Hi!              
 | 
 | The module in "Lift":http://www.liftweb.net for turning Textile markup 
 | into HTML is pretty easy to use.
 | 
 | * As you can see
 | * in this example
 |""")
res0: scala.xml.NodeSeq = 
NodeSeq(<h1>Hi!</h1>, 
, <p>The module in <a href="http://www.liftweb.net">Lift</a> for turning 
Textile markup into HTML is pretty easy to use.</p>, 
, <ul><li> As you can see</li>
<li> In this example</li>
</ul>, 
, )
```

Discussion
----------

Textile is one of many [lightweight markup language](http://en.wikipedia.org/wiki/Lightweight_markup_language), but stands out for Lift users as being easy to install and use.


See Also
--------

* [A Textile Reference](http://redcloth.org/hobix.com/textile/).
* [An online Textile to HTML tool](http://textile.thresholdstate.com/) from Threshold State.
* _Lift in Action_,  chapter 7 contains a wiki example that uses the Textile plugin.
* [Lift Source code for Textile](https://github.com/lift/modules/blob/master/textile/src/main/scala/net/liftweb/textile/TextileParser.scala).
* [Lift tests for the Textile plugin](https://github.com/lift/modules/blob/master/textile/src/test/scala/net/liftweb/textile/TextileSpec.scala).
