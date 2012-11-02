Using a new version of Scala
============================

Problem
-------

A new Scala version has just been released and you want to immediately use it in your Lift project.


Solution
---------

You may find that the latest SNAPSHOT of Lift is built using the latest Scala version. Failing that, and assuming you cannot wait for a build, providing that the Scala version is binary compatible with the latest version used by Lift, you can change your build file to force the Scala version.

For example, assuming your `build.sbt` file is set up to use Lift 2.4 with Scala 2.9.1:

```scala
scalaVersion := "2.9.1"

libraryDependencies ++= {
  val liftVersion = "2.4" 
  Seq(
    "net.liftweb" %% "lift-webkit" % liftVersion % "compile->default"
  )    
}
```

Let's assume that you now want to use Scala 2.9.2 but Lift 2.4 was only built against Scala 2.9.1. Replace `%%` with `%` for the `net.liftweb` resources and explicitly include the Scala version that Lift was built against for each Lift component:

```scala
scalaVersion := "2.9.2"

libraryDependencies ++= {
  val liftVersion = "2.4" 
  Seq(
    "net.liftweb" % "lift-webkit_2.9.1" % liftVersion % "compile->default"
  )    
}
```

Discussion
----------

In the example we have forced SBT to explicitly fetch the 2.9.1 version of the Lift resources rather than allow it to compute the URL to the Lift components.

Please note this only works for minor releases of Scala: major releases break compatibility.

See also
--------

* Mailing list discussion on [Lift and Scala 2.9.2](https://groups.google.com/forum/?fromgroups#!topic/liftweb/b4cwfpr67a8).
* SBT [Library Dependencies](https://github.com/harrah/xsbt/wiki/Getting-Started-Library-Dependencies) page describes `%` and `%%`.


