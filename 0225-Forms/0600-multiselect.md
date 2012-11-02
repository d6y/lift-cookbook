Use a select box with multiple options
======================================

Problem
-------

You want to show the user a number of options in a select box, and allow them to select multiple values.

Solution
--------

Use `SHtml.multiSelect`:

```scala
class MySnippet {
  def multi = {
    case class Item(id: String, name: String)
    val inventory = Item("a", "Coffee") :: Item("b", "Milk") :: 
       Item("c", "Sugar") :: Nil
    
     val options : List[(String,String)] = 
       inventory.map(i => (i.id -> i.name))
     
     val default = inventory.head.id :: Nil
     
     "#opts *" #> 
       SHtml.multiSelect(options, default, xs => println("Selected: "+xs))
  }
}
```

The corresponding template would be:

```html
<div class="lift:MySnippet.multi?form=post">
  <p>What can I getcha?</p>
  <div id="opts">options go here</div>
  <input type="submit" value="Submit" />
</div>
```

This will render as something like:

```hmtl
<form action="/" method="post"><div>
  <p>What can I getcha?</p>
  <div id="opts">
   <select name="F25749422319ALP1BW" multiple="true">
     <option value="a" selected="selected">Coffee</option>
     <option value="b">Milk</option>
     <option value="c">Sugar</option>
   </select>
  </div>
  <input value="Submit" type="submit">
</form>
```

Discussion
----------

Recall that an HTML select consists of a set of options, each of which has a value and a name. To reflect this, the above examples takes our `inventory` of objects and turns it into a list of (value,name) string pairs, called `options`.

The function given to `multiSelect` will receive the values (ids), not the names, of the options.  That is, if you ran the above code, and selected "Coffee" and "Milk" the function would see `List("a", "b")`.


### Selected no options ###


Be aware if no options are selected at all, your handling function is not called. This is described in ticket 1139. One way to work around this to to add a hidden function to reset the list.  For example, we could modify the above code to be a stateful snippet and remember the values we selected:

```scala
class MySnippet extends StatefulSnippet {

  def dispatch = {
    case "multi" => multi
  }
  
  case class Item(id: String, name: String)
  val inventory = Item("a", "Coffee") :: Item("b", "Milk") :: 
    Item("c", "Sugar") :: Nil
    
  val options : List[(String,String)] = inventory.map(i => (i.id -> i.name))
    
  var current = inventory.head.id :: Nil
  
  def multi = "#opts *" #> (
    SHtml.hidden( () => current = Nil) ++ 
    SHtml.multiSelect(options, current, current = _)
  )
}
```

Each time the form is submited the `current` list of IDs is set to whatever you have selected in the browser.  But note that we have started with a hidden function that resets `current` to the empty list, meaning that if the receiving function in `multiSelect` is never called, that would mean you have nothing selected. That may be useful, depending on what behaviour you need in your application. 

### Type-safe options ###

If you don't want to work in terms of `String` values for an option, you can use `multiSelectObj`.  In this variation the list of options still provides a text name, but the value is in terms of a class. Likewise, the list of default values will be a list of class instances:

```scala
val options : List[(Item,String)] = inventory.map(i => (i -> i.name))
val current = inventory.head :: Nil
```

The call to generate the multi-select from this data is similar, but note that the function receives a list of `Item`:

```scala
"#opts *" #> SHtml.multiSelectObj(options, current, 
  (xs: List[Item]) => println("Got "+xs) )
```


### Enumerations ###

You can use `multiSelectObj` with enumerations:

```scala
object Item extends Enumeration {
  type Item = Value
  val Coffee, Milk, Sugar = Value
}

import Item._
  
val options : List[(Item,String)] = 
  Item.values.toList.map(i => (i -> i.toString))
    
var current = Item.Coffee :: Nil
  
def multi = "#opts *" #> SHtml.multiSelectObj[Item](options, current, 
  xs => println("Got "+xs) )
```


See Also
--------

* _Exploring Lift_, Chapter 6, [Forms in Lift](http://exploring.liftweb.net/master/index-6.html).
* [Ticket 1139](https://www.assembla.com/spaces/liftweb/tickets/1139), Cannot clear out multiselect.
