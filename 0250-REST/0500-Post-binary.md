Accept binary data in a REST service
====================================

Problem
-------

You want to accept an image upload or other binary data in your RESTful service.

Solution
--------

Access the request body in your rest helper:

```scala
import net.liftweb.http.rest._
import net.liftweb.http._

object MyUpload extends RestHelper {
  serve {
    case "upload" :: Nil Post req => 
      for {
        bodyBytes <- req.body ?~ "No Body Bytes"
      } yield <b>got an image of {bodyBytes.length} bytes</b>
  }
}
```

Wire this into your application in `Boot.scala`, for example:

```scala
LiftRules.statelessDispatchTable.append(code.lib.MyUpload) 
```

Test this service using a tool like cURL:

```scala
\$ curl -X POST --data-binary "@dog.jpg" \
  -H 'Content-Type: image/jpg' http://127.0.0.1:8080/upload
<?xml version="1.0" encoding="UTF-8"?>
<b>got an image of 43685 bytes</b> 
```

Discussion
----------

In the above example the binary data is accessed via the `req.body`, yielding a `Box[LiftResponse]` which in this case is XML.

In the case where there is no body, a 404 would be returned with a text body of "No Body Bytes".

Note that web containers, such as Jetty and Tomcat, may place limits on the size of an upload.  You will recognise this situation by an error such as "java.lang.IllegalStateException: Form too large705784>200000".  Check with documentation for the container for changing these limits.


See Also
--------

* [Mailing list discussion](https://groups.google.com/forum/?fromgroups#!topic/liftweb/6MnWRPP3TcU) including code for restricting a request based on mime type.
* [Form too large in Jetty](http://stackoverflow.com/questions/3861455/form-too-large-exception)



