Other custom status pages
=========================

Problem
-------

You want to show a customised page for certain HTTP status codes.

Solution
--------

Use `LiftRules.responseTransformers` to match against the response and supply an alternative.

For example, suppose we want to provide a customised page for 403 ("Forbidden") statuses created in your Lift application.  In `Boot.scala` we could add the following:

```scala
LiftRules.responseTransformers.append {
  case r if r.toResponse.code == 403 => RedirectResponse("/403.html")
  case r => r
}
```

The file `src/main/webapp/403.html` will now be served for requests that generate 403 status codes.  Other requests are passed through.


Discussion
----------

`LiftRules.responseTransformers` allows you to supply `LiftResponse => LiftResponse` functions to change a response at the end of the HTTP processing cycle.  This is a very general mechanism: in this example we are matching on a status code, but we could match on anything exposed by `LiftResponse`.  We've shown a `RedirectResponse` being returned but there are many different kinds of `LiftResponse` we could send to the client.

One way to test the above example is to add the following to Boot to make all requests to `/secret` return a 403:

```scala
val Protected = If(() => false, () => ForbiddenResponse("no way"))

val entries = List(
  Menu.i("Home") / "index", 
  Menu.i("secret") / "secret" >> Protected,
  Menu.i("403") / "403" >> Hidden 
  // rest of your site map here...
)
```


See Also
--------

* _The Request/Response Lifecycle_ in [Exploring Lift](http://exploring.liftweb.net/master/index-9.html#toc-Section-9.2).
* Mailing list discussion of [custom error 403 page](https://groups.google.com/forum/?fromgroups#!topic/liftweb/9wU0hzQ0wgs%5B1-25%5D).


