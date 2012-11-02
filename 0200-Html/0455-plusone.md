Adding a Google +1 button
==========================

Problem
-------

You want to include a Google +1 button on a page.

Solution
--------

Put the markup into a snippet and invoke the snippet. For example:

```scala
object PlusOne {

 import net.liftweb.http.js.JsCmds.{Script,Run}

 def render = Script(Run("""(function() {
   var po = document.createElement('script'); 
   po.type = 'text/javascript'; po.async = true;
   po.src = 'https://apis.google.com/js/plusone.js';
   var s = document.getElementsByTagName('script')[0]; 
   s.parentNode.insertBefore(po, s);
 })();"""))

}
```

Reference the snippet to make the button show by including the script...

```html
<script class="lift:PlusOne"></script>
```

...and including the code Google ask you to include:

```html
<div class="g-plusone" data-size="medium" data-annotation="bubble"
  data-href="http://www.example.org/"></div>
```


See Also
--------

* [Google +1 Documentation](http://www.google.com/intl/en/webmasters/+1/button/index.html).



