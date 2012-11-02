Using the latest Lift build
============================

Problem
-------

You want to use the latest build ("snapshot") of Lift.


Solution
---------

You need to make two changes to your `build.sbt` file.  First, reference the snapshot repository:

```scala
resolvers += "snapshots" at "http://oss.sonatype.org/content/repositories/snapshots"
```

Second, change the `liftVersion` in your build to be 2.5-SNAPSHOT, rather than 2.4:

```scala
val liftVersion = "2.5-SNAPSHOT"
```

Restarting SBT (or issuing a `reload` command) will trigger a download of the latest build.


Discussion
----------

Production releases of Lift (e.g., "2.4"), as well as milestone releases (e.g., "2.4-M1") and release candidates (e.g., "2.4-RC1") are published into a releases repository.  When SBT downloads them, they are downloaded once.

Snapshot releases are different: they are the result of an automated build, and change often.  You can force SBT to resolve the latest versions by running the command `clean` and then `update`. 

See also
--------

* [SBT Resolvers](https://github.com/harrah/xsbt/wiki/Resolvers).
* Learn about SNAPSHOT versioning in [Maven: The Complete Reference](http://www.sonatype.com/books/mvnref-book/reference/pom-relationships-sect-pom-syntax.html).
* [SBT Command line reference](https://github.com/harrah/xsbt/wiki/Command-Line-Reference).
