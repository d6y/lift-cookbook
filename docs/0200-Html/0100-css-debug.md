Testing and debugging CSS selectors
===================================

Problem
-------

You want to explore or debug CSS selectors interactively.

Solution
--------

Use the Scala REPL to run your CSS selector:

```scala
> console             
[info] Starting scala interpreter...
[info] 
Welcome to Scala version 2.9.1.final 
Type in expressions to have them evaluated.
Type :help for more information.

scala> import net.liftweb.util.Helpers._ 
import net.liftweb.util.Helpers._

scala> val in = <a>click me</a>
in: scala.xml.Elem = <a>click me</a>

scala> val f = "a [href]" #> "http://example.org"
f: net.liftweb.util.CssSel = 
  (Full(a [href]), Full(ElemSelector(a,Full(AttrSubNode(href)))))

scala> f(in)
res0: scala.xml.NodeSeq = 
  NodeSeq(<a href="http://example.org">click me</a>)
```

Discussion
----------

The CSS selector functionality in Lift gives you a `CssSel` function which is `NodeSeq => NodeSeq`.  Knowing this, you can construct an input `NodeSeq` (called `in` above), create your CSS function (called `f`) and then apply it to get the `NodeSeq` output (called `res0`, above). 

See Also
--------

* [CSS Selector Transforms](http://simply.liftweb.net/index-7.10.html#toc-Section-7.10) in _Simply Lift_.
* Section 6.1.2 of _Lift in Action_.


