Detect if the schema has changed
==================================

Problem
-------

You do not want to automatically migrate your schema, but you want to know if it is out of date.

Solution
--------

Run `Schemifier` and capture the changes it would make if allowed.  For example, in `Boot.scala`:

```scala
val cmds = Schemifier.schemify(false, true, Schemifier.infoF _, User, Company)

if (!cmds.isEmpty) {
  error("Database schema is out of date. The following is missing: \n"+
    cmds.mkString("\n"))
}
```

Discussion
----------

The arguments and return value for `schemify` are:

 * performWrite - the example uses `false` meaning the database won't be updated.
 * structureOnly - `true` to check the tables and columns (not indexes).
 * logFunc - for logging, but only if we are writing to the database, which we are not.
 * tables (mapper objects) - the tables to include.
 * The result is a `List[String]` which are the statements required to update the database. 

From the above description you may be able to select the parameters that best fit your needs. 


See Also
--------

* [Schemifier.scala](https://github.com/lift/framework/blob/master/persistence/mapper/src/main/scala/net/liftweb/mapper/Schemifier.scala) source.
* [Mailing list discussion](https://groups.google.com/forum/?fromgroups#!msg/liftweb/DM4kYVz_Z2c/vO0t-So3vVcJ).

