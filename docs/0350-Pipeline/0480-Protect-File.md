Serving a file with access control
=================

Problem
-------

You have a file on disk, you want to allow a user to download it, but only if they are allowed to.  If they are not allowed to, explain why.


Solution
--------

Use `RestHelper` to serve the file or an explanation page.  For example, suppose we have the file `/tmp/important` and we only want selected requests to download that file from the `/download/important` URL. The structure for that would be:

```scale
object DownloadService extends RestHelper {

  // Code explained below to go here

  serve {
    case "download" :: Known(fileId) :: Nil Get req => 
      if (permitted)
        fileResponse(fileId)
      else
        Full(RedirectResponse("/sorry"))    
  }
}
```

We are allowing users to download "known" files.  That is, files which we approve of for access. We do this because  opening up the file system to any unfiltered end-user input pretty much means your server will be compromised.

For our example, `Known` is checking a static list of names:
 
```scala
val knownFiles = List("important")

object Known {
 def unapply(fileId: String): Option[String] = knownFiles.find(_ == fileId)
}
```

For requests to these known resources, we convert the REST request into a `Box[LiftResponse]`.  For permitted access we serve up the file:

```scala
private def permitted = scala.math.random < 0.5d

private def fileResponse(fileId: String): Box[LiftResponse] = for {
    file <- Box !! new java.io.File("/tmp/"+fileId)
    input <- tryo(new java.io.FileInputStream(file))
 } yield StreamingResponse(input, 
    () => input.close,
    file.length,
    ("Content-Disposition" -> "attachment; filename="+fileId) :: Nil,
    Nil, 200)
```

If no permission is given, the user is redirected to `/sorry.html`.


Discussion
----------

By turning the request into a `Box[LiftResponse]` we are able to serve up the file, send the user to a different page, and also allow Lift to handle the 404 (`Empty`) cases. 

If we added a test to see if the file existed on disk in `fileResponse` that would cause the method to evaluate to `Empty` for missing files, which triggers a 404.  As the code stands, if the file does not exist, the `tryo` would give us a `Failure` which would turn into a 404 error with a body of "/tmp/important (No such file or directory)".

Because we are testing for known resources via the `Known` extractor as part of the pattern for `/download/`, unknown resources will not be passed through to our `File` access code.  Again, Lift will return a 404 for these.  

Guard expressions can also be useful for these kinds of situations:

```scala
serve {
  case "download" :: Known(id) :: Nil Get _ if permitted => fileResponse(id)
  case "download" :: _ Get req => RedirectResponse("/sorry")
}
```

You can mix and match extractors, guards and conditions in your response to best fit the way you want the code to look and work.

See Also
--------

* Mailing list thread on [PHP's readfile equivalent for Lift](https://groups.google.com/forum/?fromgroups#!topic/liftweb/7N2OUInltUE).
* _Chatper 24: Extractors_ from [Programming in Scala](http://www.artima.com/pins1ed/extractors.html).

