Put a random value in a column
==============================

Problem
-------

You need a column to hold a random value.

Solution
--------

Use `UniqueIdField`: 

```scala
val myColumn = new UniqueIdField(this,32) {}
```

The size value, 32 in this example, controls the number of characters in the random field.


Discussion
----------

The field is a kind of `StringField` and the default value for the field comes from `StringHelpers.randomString`.  

Note the `{}` in the example: this is required as `UniqueIdField` is an abstract class.


See Also
--------

* Source for [StringHelpers](https://github.com/lift/framework/blob/master/core/util/src/main/scala/net/liftweb/util/StringHelpers.scala).




