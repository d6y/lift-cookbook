Sequencing CSS selector operations 
==================================

Problem
-------

You want your CSS selector binding to apply to the results of earlier binding expressions.

Solution
--------

Use `andThen` rather than `&` to compose your selector expressions.
For example, suppose we want to replace `<div id="foo"/>` with `<div id="bar">bar content</div>` but for some reason we needed to generate the `bar` div as a separate step in the selector expression:

```scala
sbt> console
[info] Starting scala interpreter...
[info] 
Welcome to Scala version 2.9.1.final (Java 1.7.0_05).
Type in expressions to have them evaluated.
Type :help for more information.

scala> import net.liftweb.util.Helpers._
import net.liftweb.util.Helpers._

scala> def render = "#foo" #> <div id="bar"/> andThen "#bar *" #> "bar content"
render: scala.xml.NodeSeq => scala.xml.NodeSeq

scala> render(<div id="foo"/>)
res0: scala.xml.NodeSeq = NodeSeq(<div id="bar">bar content</div>)
```

Discussion
----------

When using `&` think of the CSS selectors as always applying to the original template, no matter what other expressions you are combining.

Compare the example above with the change of replacing `andThen` with `&`:

```scala
scala> def render = "#foo" #> <div id="bar" /> & "#bar *" #> "bar content"
render: net.liftweb.util.CssSel

scala> render(<div id="foo"/>)
res1: scala.xml.NodeSeq = NodeSeq(<div id="bar"></div>)           
```

The second expression will not match as it is applied to the original input of `<div id="foo"/>`.


See Also
--------

* Mailing list discussion on: [CSS Selector in render on element ID created in the same render](https://groups.google.com/forum/?fromgroups#!topic/liftweb/fz3Pmlhzhfg).
* [CSS Selector Transforms](http://simply.liftweb.net/index-7.10.html#toc-Section-7.10) in _Simply Lift_.
* Wiki page on [Binding via CSS Selectors](http://www.assembla.com/spaces/liftweb/wiki/Binding_via_CSS_Selectors).


