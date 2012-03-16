Logging email rather than sending
========================

Problem
-------
You don't want email sent when developing your Lift application locally. 


Solution
--------

The solution is to use `Mailer.devModeSend` and here is an example: 

Declare an function and set a default hanlder in `Boot.scala`:

```scala
  def email {
    def toString(m: Any) = m match {
      case mm: MimeMultipart => mm.getBodyPart(0).getContent
      case otherwise => otherwise.toString
    }
    
    Mailer.devModeSend.default.set((m: MimeMessage) => 
    log.info("Would have sent the following mail\n%s".format(toString(m.getContent()))))
  }
```


Discussion
----------

When developing an application it is inconvient to have  to worry about setting up an SMTP server or inadverntly sending test messages to users.
It may however be useful to know what would have been sent.
You can control how and if mail is sent using the `*ModeSend` functions available for the different Lift RunModes (dev,staging, production, profile and test).

