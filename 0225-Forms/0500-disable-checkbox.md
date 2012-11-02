Conditionally disable a checkbox
=================================

Problem
-------

You want to add the `disabled` attribute to a `SHtml.checkbox` based on a conditional check.

Solution
--------

Create a CSS selector transform to add the disabled attribute, and apply it to your checkbox transform.  For example, suppose you have a simple checkbox:

```scala
class Likes {
  var likeTurtles = false
  def checkbox = "*" #> SHtml.checkbox(likeTurtles, likeTurtles = _ )
}
```

Further suppose you want to disable it roughly 50% of the time:

```scala
def disabler = if (math.random > 0.5d)
  "* [disabled]" #> "disabled"
else
  PassThru

def conditionallyDisabledCheckbox = 
  "*" #> disabler( SHtml.checkbox(likeTurtles, likeTurtles = _ ) )
```

Using `lift:Likes.conditionallyDisabledCheckbox` the checkbox would be disabled half the time.

Discussion
----------

The `disabler` method returns a `NodeSeq=>NodeSeq` function, meaning when we apply it in `conditionallyDisabledCheckbox` we need to give it a `NodeSeq`, which is exactly what `SHtml.checkbox` provides.

The `[disabled]` part of the CSS selector is selecting the disabled attribute and replacing it with the value on the right of the `#>`, which is "disabled" in this example.

What this combination means is that half the time the disabled attribute will be set on the checkbox, and half the time the checkbox `NodeSeq` will be left untouched because `PassThru` does not change the `NodeSeq`.


The example above separates the test from the checkbox only to make it easier to write this discussion section.  You can of course in-line the test, as is done in the mailing list post referenced below.


See Also
--------

* Mailing list question regarding [how to conditionally mark a SHtml.checkbox as disabled](https://groups.google.com/d/topic/liftweb/KBVhkuM1NQQ/discussion).
* _Simply Lift_ [7.10 CSS Selector Transforms](http://simply.liftweb.net/index-7.10.html).

