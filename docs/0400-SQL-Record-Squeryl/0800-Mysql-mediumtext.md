Model a column with MySQL MEDIUMTEXT
======================================

Problem
-------

You want to use MySQL's `MEDIUMTEXT` for a column, but `StringField` doesn't have this option.

Solution
--------

Use Squeryl's `dbType`:

```scala
on(mytable)(t => declare(
  t.mycolumn defineAs dbType("MEDIUMTEXT")
))
```

Discussion
----------

You can continue to use `StringField`, but regardless of the size you pass, the schema will be:

```sql
create table mytable (
    mycolumn MEDIUMTEXT not null
);
```

This recipe is not specific to Lift, and will work wherever you use Squeryl.

See Also
--------

* Squeryl [schema defintion](http://squeryl.org/schema-definition.html) page.
* [MySQL, Squeryl and MEDIUMTEXT with Record](https://groups.google.com/forum/?fromgroups#!topic/liftweb/TXbDGdX54LQ) mailing list discussion.
