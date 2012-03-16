Developing using eclipse with sbt
==============================

Problem
-------

You want to develop your Lift application using your eclipse, hitting reload in your browser to see changes.

Solution
---------

You will need to have the [Scala IDE for Eclipse](http://scala-ide.org/) installed. There is a link in the See also section with instructions how to accomplish this.
Add the following to `plugins.sbt`, which can be found in the `project` directory.

```scala
resolvers += Classpaths.typesafeResolver

addSbtPlugin("com.typesafe.sbteclipse" % "sbteclipse-plugin" % "2.0.0")
```
You can the create eclipse project files within sbt by entering the following 

```scala
eclipse
```

Run SBT while you are editing to handle compilation of Scala files. Start `sbt` and enter the following:

```scala
~; container:start; container:reload /
```

When you save a source file in your editor, SBT will detect this, compile the file, and reload the web container.

Discussion
----------

An SBT command prefixed with `~` makes that command run when files change.  The first semicolon introduces a sequence of commands, where if the first command succeeds, the second will run.  The second semicolon means the `reload` command will run if the `start` command ran OK.
The restarting of the web container isn't always as efficient as you'd like.  This can often be avoided by using JRebel, which will be the subject of a future recipe.


See also
--------

* [SBT Triggered Execution](https://github.com/harrah/xsbt/wiki/Triggered-Execution)
* [SBT Command Line Reference](https://github.com/harrah/xsbt/wiki/Command-Line-Reference)
* [SBT Web Plugin Commands](https://github.com/siasia/xsbt-web-plugin/wiki)
* [JRebel](http://zeroturnaround.com/jrebel/)
* [ScalaIDE download](http://scala-ide.org/download/current.html)

