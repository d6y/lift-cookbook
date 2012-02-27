Streaming content
=================

Problem
-------

You want to stream content back to the web client.

Solution
--------

Use `OutputStreamResponse`, supplying it with a function that takes an `OutputStream` to write to. 

In this example we'll stream all the integers from 1:

```scala
import net.liftweb.http.{Req,OutputStreamResponse}
import net.liftweb.http.rest._

object Numbers extends RestHelper {

  // Generate numbers, converted to Array[Byte]
  def infinite = Stream.from(1).map(num2bytes)

  def num2bytes(x: Int) = (x + "\n") getBytes("utf-8")
  
  serve {
    case Req("numbers" :: Nil, _, _) => 
   	  OutputStreamResponse( (out) => infinite.foreach(out.write) ) 
  }
}
```

Wire this into Lift in `Boot.scala`:

```scala
LiftRules.dispatch.append(Numbers)
```

Visiting `http://127.0.0.1:8080/numbers` will start producing the integers from 1, with a 200 status code.

For more control there are a variety of signatures for `OutputStreamResponse` including the most general:

```scala
case class OutputStreamResponse(
  out: (OutputStream) => Unit,  
  size: Long, 
  headers: List[(String, String)], 
  cookies: List[HTTPCookie], 
  code: Int) 
```

Discussion
----------

The function you give as the first argument to `OutputStreamResponse` is called with the output stream to the client. This means that the bytes you are writing to the `out` stream are being written to the client. 

Any headers you set (such as `Content-type`), or status code, may already have been set by the time your function is called.  Note that the `Content-length` header is only set if `size` is not `-1`.

There are two related types of response: `InMemoryResponse` and `StreamingResponse`

### InMemoryResponse

`InMemoryResponse` is useful if you assembled the full content to send to the client.  The signature is straightforward:

```scala
case class InMemoryResponse(
  data: Array[Byte], 
  headers: List[(String, String)], 
  cookies: List[HTTPCookie], 
  code: Int)
```


### StreamingResponse

`StreamingResponse` pulls bytes into the output stream.  This contrasts with `OutputStreamResponse`, where you are pushing data to the client.

Construct this type of response by providing a method that can be read from:

```scala
case class StreamingResponse(
  data: {def read(buf: Array[Byte]): Int}, 
  onEnd: () => Unit, 
  size: Long, 
  headers: List[(String, String)], 
  cookies: List[HTTPCookie], 
  code: Int)
```

Notice the use of a structural type for the `data` parameter.  Anything with a mathcing `read` method can be given here, including `java.io.InputStream`-like objects, meaning  `StreamingResponse` can act as a pipe from input to output. Lift pulls 8k chunks from your `StreamingResponse` to send to the client. 

Your `data` `read` function should follow the semantics of Java IO and return "the total number of bytes read into the buffer, or -1 is there is no more data because the end of the stream has been reached".

See Also
--------

* [LiftResponse.scala source](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/http/LiftResponse.scala)
* [java.io.InputStream contract description](http://docs.oracle.com/javase/6/docs/api/java/io/InputStream.html#read%28byte[]%29)



