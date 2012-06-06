Ajax JSON form processing
========================

Problem
-------

You want to process a form via Ajax, sending the data in JSON format.

Solution
--------

Make use of Lift's `jlift.js` Javascript and `JsonHandler` code. Consider this HTML, which is not in a form, but includes `jlift.js`:

```html
<div class="lift:JsonForm" >

 <!--  required for JSON forms processing -->
 <script src="/classpath/jlift.js" class="lift:tail"></script>

 <!--  placeholder script required to process the form -->
 <script id="jsonFormScript" class="lift:tail"></script>

 <div id="formToJson" name="formToJson">
  <input type="text" name="name" value="Royal Society" />
  <input type="text" name="motto" value="Nullius in verba" />
  <input type="submit" name="sb" value="go!" />
 </div>
 <div id="result"></div>
</div>
```

The server-side code to accept the input as JSON would be as follows:

```scala
package code.snippet

import net.liftweb.util._
import Helpers._

import net.liftweb.http._
import net.liftweb.http.js._
import JsCmds._

import scala.xml._

class JsonForm {

  def render = 
     "#formToJson" #> ((ns:NodeSeq) => SHtml.jsonForm(jsonHandler, ns)) &
     "#jsonFormScript" #> Script(jsonHandler.jsCmd)   
    
    object jsonHandler extends JsonHandler {
      
      def apply(in: Any): JsCmd = in match {
          case JsonCmd("processForm", target, params: Map[String, _], all) => 
            val name = params.getOrElse("name", "No Name")
            val motto = params.getOrElse("motto", "No Motto")
            SetHtml("result", 
                Text("The motto of %s is %s".format(name,motto)) )      
          
          case _ => 
            SetHtml("result",Text("Unknown command"))
      }

    }
}
```

If you click the go button and observe the network traffic, you'll see the following sent to the server:

```json
{ "command":"processForm",
  "params":{"name":"Royal Society","motto":"Nullius in verba"} }
```

The server will send back JavaScript to update the `results` div with "The motto of the Royal Society is Nullius in verba".

Discussion
----------

The key components in the example are:

1. `jlift.js` script that makes various JSON functions available; and

2. generated JavaScript code (`jsonHandler.jsCmd`) that is included on the page to perform the actual submission.

In the binding, `SHtml.jsonForm` takes the `jsonHandler` object which will process the form elements, and wraps your template, `ns`, with a `<form>` tag.  We also bind the JavasScript required to the  `jsonFormScript` placeholder.

When the form is submitted, the `JsonHandler.apply` allows us to pattern match on the input and extract the values we need from a `Map`. Note that compiling this code will produce a warning as `Map[String,_]` will be "unchecked since it is eliminated by erasure".

If you are implementing a REST service to process JSON, consider using Rest helpers in Lift to do that.


See Also
--------

* [Using JSON forms with AJAX in Lift Framework](http://www.javabeat.net/2011/05/using-json-forms-with-ajax-in-lift-framework/).
* _Lift in Action_, section 9.1.4 "Using JSON forms with AJAX".
* Example Lift application demonstrating [Simple form](https://github.com/marekzebrowski/lift-basics) processing.
* Section 10.4, JSON, in [Exploring Lift](http://exploring.liftweb.net/master/index-10.html).
* [Nullius in verba](http://en.wikipedia.org/wiki/Nullius_in_verba).

