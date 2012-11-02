Adding validation to a field
=============================

Problem
-------

You want to add validation to a field in your model.

Solution
--------

Override `validations`. For example:

```scala
val title = new StringField(this, 256) {
  override def validations = valMinLen(1, "Title cannot be blank") _ :: 
    super.validations
}
```

In your snippet you can check the validations, for example:

```scala
val thing = MyThing.createRecord.title(title)
thing.validate match {
  case Nil =>
    // No validation problems, so code here to save thing
    S.redirectTo("/success")
  case xs => // One or more validation problems! 
    S.error(xs)  
}
```

In your template, you can reference the column to show any error:

```html
<p class="lift:Msg?id=title_id&errorClass=error">Msg to appear here</p>
```

Discussion
----------

The built-in validations are:

* `valMinLen` -- validate a string is at least a given length, as shown above.
* `valMaxLen` -- validate that a string is not above a given length.
* `valRegex` -- validate a string matches the given pattern.

An example of regular expression validation would be:

```scala
import java.util.regex.Pattern

val url = new StringField(this, 1024) {
  override def validations = 
    valRegex( Pattern.compile("^https?://.*"), 
              "URLs should start http:// or https://") _ :: 
    super.validations
}
```


See Also
--------

* Source for [BaseField.scala](https://github.com/lift/framework/blob/master/core/util/src/main/scala/net/liftweb/util/BaseField.scala) which includes the definition of `StringValidators`.



