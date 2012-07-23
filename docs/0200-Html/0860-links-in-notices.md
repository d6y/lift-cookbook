Links in notices
================

Problem
-------

You want to include a clickable link in your `S.error`, `S.notice` or `S.warning` messages.

Solution
--------

Include a `NodeSeq` containing a link in your notice:

```scala
S.error("checkPrivacyPolicy", 
  <span>See our <a href="/policy">privacy policy</a></span>)
```

You might pair this with the following in your template:

```html
<div class="lift:Msg?id=checkPrivacyPolicy"></div>
```


See Also
--------

* [Lift Notices and Auto Fadeout](http://www.assembla.com/spaces/liftweb/wiki/Lift_Notices_and_Auto_Fadeout) wiki page.
* Mailing list question: [Is there a way for the display of the S.errror to have a clickable URL in it?](https://groups.google.com/forum/?fromgroups#!topic/liftweb/Q6ToHnebOB0)


