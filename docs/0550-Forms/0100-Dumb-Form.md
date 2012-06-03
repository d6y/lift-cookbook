Dumb POST form
========================

Problem
-------

You want to process form data in old-fashioned, non-ajax way

Solution
--------

Provided that you don't want Screen or Wizard you can:

define form in html template, and wrap it in a snippet
```html
<span  class="lift:DumbForm">
<form name="dumbForm.html" action="/dumbForm.html" method="post">
	<input type="text" name="it" value="something" >
	<input type="submit" value="Go">
</form> 
</span>
```

write a snippet
```scala
class DumbForm {
	// actual processing
	val inputParam = for {
	  //that only works in POST request
	  r <- S.request if r.post_?
	  v <- S.param("it")
	} yield v
  
	def render(in:NodeSeq) :NodeSeq = {
	  println ("render called")
	  println ("input nodeseq" )
	  println(in)
	  inputParam match {
	    case Full(x) => {
	      // render input parameter
	      println("we have input, render "+x)
	      ("#result *+" #> x) (in)
	    }
	    case _ =>  {
	      println("No input present")
	      //pass through input
	      in
	    }
	  }
	}
}
```


Discussion
----------
DumbForm snippet calculates input params using for-comprehansion. If calculation produces result render method gets Full(x) 
match and produces output.
You can make actual processing in inputParam calculation, coding real action instead of just yielding  value

See Also
--------

* [Simple forms](https://github.com/marekzebrowski/lift-basics), Forms processing


