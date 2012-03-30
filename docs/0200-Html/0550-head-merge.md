Adding to the head of a page
============================

Problem
-------

You use a template for layout, but on one specific page you need to add something to the `<head>` section.


Solution
--------

Use the `lift:head` snippet or CSS class so Lift knows to merge the contents with the `<head>` of your page.  For example, suppose you have the following contents in `templates-hidden/default.html`:

```html
<html lang="en" xmlns:lift="http://liftweb.net/"> 
  <head> 
    <meta charset="utf-8"></meta> 
    <title class="lift:Menu.title">App: </title>
    <script id="jquery" src="/classpath/jquery.js" 
      type="text/javascript"></script>
    <script id="json" src="/classpath/json.js" 
      type="text/javascript"></script>
 </head>
 <body>
 	 <div id="content">The main content will get bound here</div>
 </body>
</html>
```

Also suppose you have `index.html` on which you want to include `my.css` just for that page.  Do so by including the CSS in the part of the page that will get processed and mark it for the head with `lift:head`:

```html
<!DOCTYPE html>
<html>
 <head>
   <title>Special</title>
 </head>
 <body class="lift:content_id=main">
  <div id="main" class="lift:surround?with=default;at=content">
   <link class="lift:head" rel="stylesheet" href="/my.css" type='text/css'>
   <h2>Hello</h2>
  </div>
 </body>
</html>
```

Note that this `index.html` page is validated HTML5, and will produce a result with the custom CSS inside the `<head>` tag, something like this:

```html
<!DOCTYPE html>
<html lang="en">
 <head> 
  <meta charset="utf-8"> 
  <title>App:  Home</title>
  <script type="text/javascript" 
    src="/classpath/jquery.js" id="jquery"></script>
  <script type="text/javascript" 
    src="/classpath/json.js" id="json"></script>
  <link rel="stylesheet" href="/my.css" type="text/css">
 </head>
 <body>
   <div id="main">
     <h2>Hello</h2>
   </div>
  <script type="text/javascript" src="/ajax_request/liftAjax.js"></script>
  <script type="text/javascript"> 
  // <![CDATA[
  var lift_page = "F557573613430HI02U4";
  // ]]>
  </script>
 </body>
</html>
```

Discussion
----------

If you find your tags not appearing the the `<head>` section, check that the HTML in your template and page is valid HTML5. 

You can also use `<lift:head>...</lift:head>` to wrap a number of expressions, and will see `<head_merge>...</head_merge>` used in code examples, as an alternative to `<lift:head>`.


See Also
--------

* Wiki page on [HtmlProperties XHTML and HTML5](http://www.assembla.com/spaces/liftweb/wiki/HtmlProperties_XHTML_and_HTML5).
* Mailing list discussion on a [designer friendly way of head merge. 
](https://groups.google.com/forum/?fromgroups#!topic/liftweb/rG_pOXdp4Ew).
* [W3C HTML validator](http://validator.w3.org/).
