Plain old form processing
========================

Problem
-------

You want to process form data in a regular old-fashioned, non-Ajax, way.

Solution
--------

Extract form values with `S.param`.   For example, we can show a form, process an input value, and echo the value back out.  Here we have `dumbForm.html` which contains a form wrapped in a snippet:

```html
<div class="lift:DumbForm">

<form  action="/dumbForm.html" method="post">
  <input type="text" name="it" value="something" >
  <input type="submit" value="Go" >
</form> 

<div id="result"> </div>

</div>
```

Pick out the values in the snippet:

```scala
package code.snippet

import net.liftweb.util._
import net.liftweb.common._
import Helpers._
import net.liftweb.http._

class DumbForm {

  val inputParam = for {
    r <- S.request if r.post_?  // restricting to POST requests
    v <- S.param("it")
  } yield v
  
  def render = inputParam match {
      case Full(x) => 
        println("Input is: "+x)
        "#result *" #> x
      
      case _ =>  
        println("No input present! Rendering input form HTML")
        PassThru  
  }
  
}
```

When you run this code you'll see `No input present! Rendering input form HTML` on the console, and when you press "Go" you'll see `Input is: something` and
the "something" will appear on the page.

Discussion
----------

The `DumbForm` snippet extracts the input parameter using a for comprehension.  The result will be of type `Box[String]` which we then match on to decide what to do next.

In this example, we are also checking that the request is a POST request before extracting the value of the `it` form parameter.

Screen or Wizard provide alternatives for form processing, but sometimes you just want to pull values from a request, as demonstrated in this recipe.


See Also
--------

* _Simply Lift_, section 4.1, [Old Fashioned Dumb Forms](http://simply.liftweb.net/index-4.1.html#toc-Section-4.1) and 4.9 [But sometimes Old Fashioned is good](http://stable.simply.liftweb.net/#toc-Section-4.9).
* [Simple forms](https://github.com/marekzebrowski/lift-basics), example Lift project.


