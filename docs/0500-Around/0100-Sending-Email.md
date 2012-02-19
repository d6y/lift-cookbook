Sending plain text email
========================

Problem
-------

You want to send a plain email from your Lift applicaton.

Solution
--------

Use the `Mailer`:

```scala
import net.liftweb.util.Mailer._
Mailer.sendMail(
  From("you@example.org"),
  Subject("Hello"),
  To("other@example.org"),
  PlainMailBodyType("Hello from Lift") )
```


Discussion
----------

`Mailer` sends the message asynchronously, meaning `sendMail` will return immediately, so you don't have to worry about the time costs of negotiating with an SMTP server. There's also a `blockingSendMail` method if you want to wait.

By default, the SMTP server used will be `localhost`.  You can change this by setting the `mail.smtp.host` property. For example, add the line `mail.smtp.host=smtp.example.org` to `src/mail/resources/props/default.props`.  Mailer also supports JNDI as a source of email sessions.
 
The signature of `sendMail` requires a `From`, `Subject` and then any number of `MailTypes`.  In the example we added two: `PlainMailBodyType` and `To`.  You can add others including `BCC`, `ReplyTo` and `MessageHeader` (a name and value pair), and you can add them multiple times.

The default character set is UTF-8.  If you need to change this replace the use of `PlainMailBodyType` with `PlainPlusBodyType("Hello from Lift", "ISO8859_1")`.

See Also
--------

* [Exploring Lift](http://exploring.liftweb.net/master/index-F.html#toc-Appendix-F), Appendix F.


