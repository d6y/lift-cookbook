Sending email with attachments
==============================

Problem
-------

You want to send an email with one or more attachments.

Solution
--------

Use Mailer's `XHTMLPlusImages` body types:

```scala
val content = "Planet,Discoverer\r\n" + 
  "HR 8799 c, Marois et al\r\n" +
  "Kepler-22b, Kepler Science Team\r\n"

case class CSVFile(bytes: Array[Byte], 
  filename: String = "file.csv",
  mime: String = "text/csv; charset=utf8; header=present" )

val attach = CSVFile(content.mkString.getBytes("utf8"))

val body = <p>Please research the enclosed.</p>

val msg = XHTMLPlusImages(body, 
  PlusImageHolder(attach.filename, attach.mime, attach.bytes))

Mailer.sendMail(
  From("me@example.org",
  Subject("Planets"),
  To("you@example.org"), 
  msg)
```

Discussion
----------

`XHTMLPlusImages` can also accept more than one `PlusImageHolder` if you have more than one file to attach.

Messages are sent using the "related" multi-part mime heading with "inline" disposition.

See Also
--------

* Lift ticket 1197 to [improve Mailer functionality for attachments](http://www.assembla.com/spaces/liftweb/tickets/1197)

* Wikipedia entry on [Multipurpose Internet Mail Extensions (MIME)](http://en.wikipedia.org/wiki/MIME)
