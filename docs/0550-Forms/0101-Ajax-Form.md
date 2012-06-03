Ajax Form
========================

Problem
-------

You want to process form in ajax way, without reloading the whole page

Solution
--------

define form in html template, and wrap it in an form.ajax snippet and your own snippet
```html
<span class="lift:form.ajax">
<span class="lift:AjaxFormOne">
<form >
	<input type="text" name="infor" value="" />
	<input type="text" name="in" value="This is sparta" />
	<input type="submit" name="sb" value="go!" />
</form>
<div id="result">
</div>
</span>
</span>
```

write a snippet
```scala
object AjaxFormOne {
  var inputVal="default"
  var infor="i"
  def process() :JsCmd = {
    //that is called when the form is submitted
    println("process ok "+inputVal + infor)
    SetHtml("result", Text(inputVal + " "+infor) )
  }
  def render = {
    println("render")
    "name=infor" #> SHtml.text(infor, infor = _) &
    "name=in" #> ( SHtml.text(inputVal, inputVal = _ ) ++ SHtml.hidden(process))
  }
}
```

Discussion
----------
Key componentes are:
1. SHtml.text(getter, setter)
2. SHtml.hidden(process)
Process is a method that is invoked on server during form submission.
It can do whatever processing is necessery and emits JsCmd - a javascript code that changes view.

--------

* [Simple forms](https://github.com/marekzebrowski/lift-basics), Forms processing


