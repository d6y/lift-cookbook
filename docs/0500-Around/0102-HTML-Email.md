Sending HTML email
==================

Problem
-------

You want to send a HTML email from your Lift applicaton.

Solution
--------

Give `Mailer` a `NodeSeq` containing your HTML message:

```scala
import net.liftweb.util.Mailer._

val html = <html>
   <head>
     <title>Hello</title>
   </head>
   <body>
    <h1>Hello</h1>
   </body>
  </html>

Mailer.sendMail(
  From("Myself <me@example.org>"),
  Subject("Hello"),
  To("you@example.org"),
  html)
```


Discussion
----------

An implict converts the `NodeSeq` into a `XHTMLMailBodyType`.  This ensures the mime type of the email is "text/html". Despite the name of XHTML, the message is to converted into a string for transmission using HTML5 semantics.

The character encoding for HTML email, UTF-8, can be changed by setting `mail.charset` in your Lift properties file.



