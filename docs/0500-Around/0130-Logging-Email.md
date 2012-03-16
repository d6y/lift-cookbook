Logging email rather than sending
========================

Problem
-------
You don't want email sent when developing your Lift application locally, but you do want to see what would have been sent. 


Solution
--------

The solution is to use `Mailer.devModeSend` and here is an example for `Boot.scala`: 

```scala
import net.liftweb.util.Mailer._
import javax.mail.internet.{MimeMessage,MimeMultipart}
  
def stringify(m: Any) = m match {
  case mm: MimeMultipart => mm.getBodyPart(0).getContent
  case otherwise => otherwise.toString
}

Mailer.devModeSend.default.set( (m: MimeMessage) => 
  logger.info("Would have sent "+stringify(m.getContent))
)
```

This example is changing the behaviour of `Mailer` when your Lift application is in developer mode (which it is by default).  We are logging a message only, and using a utility function to get the contents of the first body part of the message.  The key part is setting a `MimeMessage => Unit` function on `Mailer.devModeSend`.

Discussion
----------

When developing an application it is inconvenient to have  to worry about setting up an SMTP server or inadvertently sending test messages to users.
The above is a useful way to know what would have been sent.

You can control how and if mail is sent using the `*ModeSend` functions available for the different Lift RunModes (dev, staging, production, profile, pilot and test). The default is to send email, except for `testModeSend`, which only logs the send. 



    

