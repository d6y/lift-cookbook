Record Lifecycle
================

Problem
-------

You want to do something when a record is created, updated or deleted.

Solution
--------

Override the `callbacks` on your Squeryl schema:

```scala
object Bookstore extends Schema {

  val books = table[Book]

  override def callbacks = Seq( 
      afterInsert(books) call { b =>
          println("New book added "+b)
      }
  )
}
```

The `afterInsert` call is returning a class with a `call` method which, in this example, expects a `Book => Unit` function.

Discussion
----------

The callbacks available are: `beforeInsert`, `beforeUpdate`, `beforeDelete`; and `afterInsert`, `afterUpdate`,  `afterDelete`.


See Also
--------

* Squeryl [getting started](http://squeryl.org/getting-started.html) page.
* Mailing list on [Using lifecicle hooks with squeryl record - before, after - insert, update, delete](https://groups.google.com/forum/?fromgroups#!topic/liftweb/Qd7QfLpLRYI).

