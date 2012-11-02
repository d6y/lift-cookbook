Sending authenticated email
===========================

Problem
-------

You need to authenticate with an SMTP server to send email.

Solution
--------

Set the `Mailer.authenticator` in `Boot` with the credentials for your SMTP server and enable the `mail.smtp.auth` flag in your Lift props file.

Modify `Boot.scala` to include:

```scala
import net.liftweb.util.Mailer._
import javax.mail.{Authenticator,PasswordAuthentication}

Mailer.authenticator = for { 
  user <- Props.get("mail.user")
  pass <- Props.get("mail.password") 
} yield new Authenticator {
  override def getPasswordAuthentication = 
    new PasswordAuthentication(user,pass) 
}
```

In this example we expect the username and password to come from Lift properties, so we need to modify `src/main/resources/props/default.props` to include them:

```scala
mail.smtp.auth=true
mail.user=me@example.org
mail.password=correct horse battery staple
mail.smtp.host=smtp.sendgrid.net
```

Discussion
----------

We've used Lift properties as a way to configure SMTP authentication.  This has the benefit of allowing us to enable authentication for just some run modes.  For example, if our `default.props` did not contain authentication settings, but our `production.default.props` did, then no authentication would happen in development mode, ensuring we can't accidentally send email outside of a production environment.

But you don't have to use a properties file for this (the Lift Mailer also supports JNDI). However, some mail services do require `mail.smtp.auth=true` to be set.


See Also
--------

* The [com.sun.mail.smtp description](http://javamail.kenai.com/nonav/javadocs/com/sun/mail/smtp/package-summary.html)


