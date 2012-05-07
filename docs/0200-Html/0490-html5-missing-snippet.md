Snippet not found when using HTML5
==================================

Problem
-------

You're using Lift with the HTML5 parser and one of your snippets, perhaps `<lift:HelloWorld.howdy />`, is rendering with a "Class Not Found" error.

Solution
--------

Switch to the designer-friendly snippet invocation mechanism.  E.g.,

```scala
<div class="lift:HellowWorld.howdy">...</div>
```

Discussion
----------

The HTML5 parser and the traditional Lift XHTML parser have different behaviours, in particular converting elements and attributes to lower case when looking up snippets.  The two links in the _See Also_ section gives a more complete description. 

See Also
--------

* [Html5 and XHTML are different](https://groups.google.com/forum/?fromgroups#!topic/liftweb/H-xe1uRLW1c) important notes from the mailing list.
* Wiki page on [HtmlProperties, XHTML and HTML5](http://www.assembla.com/wiki/show/liftweb/HtmlProperties_XHTML_and_HTML5).
