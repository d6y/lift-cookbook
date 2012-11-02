Failing to match on a file suffix
=================================

Problem
-------

You're trying to match on a file suffix (extension), but your match is failing.

Solution
--------

Ensure the suffix you're matching on is included in `LiftRules.explicitlyParsedSuffixes`.

As an example, perhaps you want to match anything ending in `.csv` at your `/reports/` URL:

```scala
case Req("reports" :: name :: Nil, "csv", GetRequest) =>
  Text("Here's your CSV report for "+name)
```

You're expecting `/reports/foo.csv` to produce "Here's your CSV report for foo", but you get a 404.

In `Boot.scala` add the following:

```scala
LiftRules.explicitlyParsedSuffixes += "csv"
```

Discussion
----------

This is the flip side of the _Missing file suffix_ recipe: Lift only splits out the suffixes it knows about in `LiftRules.explicitlyParsedSuffixes`.

Without adding ".csv" to the `explicitlyParsedSuffixes`, the example URL would match with...

```scala
case Req("reports" :: name :: Nil, "", GetRequest) => ... 
```

...with `name` set to "foo.csv" not "foo".


See Also
--------

* [Missing file suffix](Missing+file+suffix.html) recipe.
* [REST Requst suffix matching](https://groups.google.com/d/topic/liftweb/UwZQ8f2MmLE/discussion) mailing list discussion.
* [REST the hard way](http://simply.liftweb.net/index-5.2.html), section 5.2 of _Simply Lift_.
* [Making it easier with RestHelper](http://simply.liftweb.net/index-5.3.html), section 5.3 of _Simply Lift_.

