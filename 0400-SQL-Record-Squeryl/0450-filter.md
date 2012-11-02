Modify a field value before it is set
=====================================

Problem
-------

You want to modify the value of a field, so the value in your model is the modified version.

Solution
--------

Override `setFilter`. For example, to remove leading and trailing whitespace entered by the user:

```scala
val title = new StringField(this, 256) {
   override def setFilter = trim _ :: super.setFilter
}
```

Discussion
----------

The built-in filters are:

* `crop` -- enforces the field's min and max length by truncation.
* `trim` -- applies `String.trim` to the field value.
* `toUpper` and `toLower` -- change the case of the field value.
* `removeRegExChars` -- removes matching regular expression characters.
* `notNull` -- coverts null values to an empty string.

See Also
--------

* Source for [BaseField.scala](https://github.com/lift/framework/blob/master/core/util/src/main/scala/net/liftweb/util/BaseField.scala) which includes the definition of the filters. 




