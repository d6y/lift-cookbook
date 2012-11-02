Missing file suffix
===================

Problem
-------

Your RestHelper expects a filename as part of the URL, but the suffix (extension) is missing, and you need it.

Solution
--------

Access `req.path.suffix` to recover the suffix.  For example, when processing `/download/123.png` you want to be able reconstruct `123.png`:

```scala
private def reunite(name: String, suffix: String) =
  if (suffix.isEmpty) name else name+"."+suffix

serve {
  case "download" :: name :: Nil Get req => 
    Text("You requested "+reunite(name, req.path.suffix))
}
```

Requesting this URL with a command like cURL will show you the filename as expected:

```
\$ curl http://127.0.0.1:8080/download/123.png
<?xml version="1.0" encoding="UTF-8"?>
You requested 123.png  
```

Discussion
----------

When Lift parses a request it splits the request into constituent parts (e.g., turning the path into a `List[String]`), and this includes a separation of some suffixes.  This is great for pattern matching when you want to change behaviour based on the suffix, but a hinderance in this particular situation.

Only those suffixes defined in `LiftRules.explicitlyParsedSuffixes` are split from the filename. This includes many of the common file suffixes (such as "png", "atom", "json") and also some you may not be so familiar with, such as "com".  That last one is the cause of URLs that contain email addresses being split from "user@example.org" into  "user@example" and a suffix of "com".

You can modify `LiftRules.explicitlyParsedSuffixes` to be whatever set of values you want.

Note that if the suffix is not in `explicitlyParsedSuffixes`, the suffix will be an empty String and the `name` (in the above example) will be the file name with the suffix still attached. 


See Also
--------

* Source for [HttpHelpers.scala](https://github.com/lift/framework/blob/master/core/util/src/main/scala/net/liftweb/util/HttpHelpers.scala) where you can find the default list of known suffixes.
* Mailing list discussion [RestHelper GET strips off .com when GETting email as parameter with .com address](https://groups.google.com/forum/?fromgroups#!topic/liftweb/zj8kazJPzmI).
* [REST helper: how to get file extension](https://groups.google.com/forum/?fromgroups#!topic/liftweb/h5-LdtRDfiw) mailing list discussion.


