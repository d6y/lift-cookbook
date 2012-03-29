Avoiding CSS and JavaScript caching
===================================

Problem
-------

You've modified CSS or JavaScript in your application, but web browsers have cached your resources and are using the older versions.

Solution
--------

Add the `lift:with-resource-id` class attribute to script or link tags:

```html
<script class="lift:with-resource-id" src="/myscript.js" 
 type="text/javascript"></script>
```

The addition of this class will cause Lift to append a "resource id" to your `src` (or `href`), and as this resource id changes each time Lift starts, it defeats browser caching.

The resultant HTML might be:

```html
<script src="/myscript.js?F619732897824GUCAAN=_" 
  type="text/javascript" ></script>
```

Discussion
----------

If you need some other behaviour from `with-resource-id` you can assign a new function of type `String => String` to `LiftRules.attachResourceId`.  The default implementation, shown above, takes the resource name ("/myscript.js" in the example) and returns the resource name with an id appended.  See the `LiftRules` source for additional notes.

Gotcha: Avoid wrapping `<lift:with-resource-id>...<lift:with-resource-id>` around content in the `<head>` of your page as the HTML5 parser will move it outside of the head section.
 
See Also
--------

* Chapter 6 of _Lift in Action_.
* Mailing list discussion of [lift:with-resource-id and html5](https://groups.google.com/forum/?fromgroups#!msg/liftweb/93U-7GY0FuY/Y-T7BESuOwAJ).
* [LiftRules.scala](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/http/LiftRules.scala).

