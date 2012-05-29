Returning snippet markup unchanged
==================================

Problem
-------

You want a snippet to return the original markup associated with the snippet invocation.

Solution
--------

Use the `PassThru` transform that does not change the nodes.  For example, you have a snippet which performs a transforms when some condition is met, but if the condition is not met, you want the snippet return the original markup:

```scala
if (somethingOK)
  ".myclass *" #> <p>Everything is OK</p>
else
  PassThru
```

Discussion
----------

`PassThru` is a `NodeSeq => NodeSeq` function that returns the input it is given (an identity function).


See Also
--------

* Mailing list discussion: [How to return the original markup associated with snippet invocation](https://groups.google.com/forum/?fromgroups#!topic/liftweb/A69tyIBBSdg).
* [BindHelpers.scala](https://github.com/lift/framework/blob/master/core/util/src/main/scala/net/liftweb/util/BindHelpers.scala) source where `PassThru` is defined.
* _Simply Lift_ section [7.10 CSS Selector Transforms](http://simply.liftweb.net/index-7.10.html#toc-Section-7.10).
