Add CSS class to an Ajax Form
=============================

Problem
-------

You want to set the CSS class of an AJAX form.

Solution
--------

Name the class via `?class=` query parameter:

```html
<form class="lift:form.ajax?class=myClass">
...
</form>
```

Discussion
----------

If you need to set multiple CSS classes, encode a space between the class names, e.g., `class=myClass%20anotherClass`.


See Also
--------

* _Simply Lift_ on [Ajax](http://simply.liftweb.net/index-4.8.html).
* Mailing list on [Attaching CSS class to ajax form using designer friendly template doesn't work](https://groups.google.com/forum/?fromgroups#!topic/liftweb/EEINT9t8Wd4).


