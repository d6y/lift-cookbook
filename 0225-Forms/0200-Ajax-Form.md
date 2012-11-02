Ajax form processing
====================

Problem
-------

You want to process a form on the server via Ajax, without reloading the whole page.

Solution
--------

Mark your form as an Ajax form with `lift:form.ajax` and supply a function to run on the server when the form is submitted.  Given this form...

```html
<div class="lift:AjaxExample">
 <form class="lift:form.ajax">
  <input type="text" name="info" value="" />
  <input type="submit" name="sb" value="go!" />
 </form>
 <div id="result"></div>
</div>
```

...we use the following snippet to accept the text field input of `info` and send back a JavasScript command to update the `result` div with the value sent to us:

```scala
package code.snippet

import net.liftweb.util.Helpers._
import net.liftweb.http.SHtml
import net.liftweb.http.js._
import JsCmds._

import scala.xml.Text

class AjaxExample {
  
  var inputVal = "default"

  def process(): JsCmd = {
    println("Received: "+inputVal)
    SetHtml("result", Text(inputVal))
  }

  def render = {
    "name=info" #> ( 
        SHtml.text(inputVal, inputVal = _) ++ 
        SHtml.hidden(process) )
  }

}
```

Discussion
----------

The form's `info` input is bound to a `SHtml.text` box which will set the local `inputVal` variable to the value submitted by the form.

The hidden field instructs Lift to call the `() => Any` function (`process`, in this example) when the form is submitted.  The end result is the text entered is echoed back by setting the HTML node `result`. There are many other `JsCmd`s you could send, including `Noop` if you decide to send nothing.

In `SHtml` you will see functions starting with "ajax" (e.g., `ajaxText`).  These are great for field-level Ajax interactions, such as triggering actions on input or selection changes.


See Also
--------

* _Simply Lift_, chapter 4.8 [Ajax](http://stable.simply.liftweb.net/#toc-Section-4.8).
* Example [simple forms](https://github.com/marekzebrowski/lift-basics) Lift project.
* [Server side function order](http://www.assembla.com/spaces/liftweb/wiki/cool_tips) on the Lift Cool Tips Wiki page.
* [SHtml Scala Doc](http://scala-tools.org/mvnsites/liftweb-2.4/net/liftweb/http/SHtml.html).
* Lift's [Ajax Demo page](http://demo.liftweb.net/ajax).

