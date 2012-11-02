Developing using Eclipse
========================

Problem
-------

You want to develop your Lift application using the Eclipse IDE, hitting reload in your browser to see changes.

Solution
---------

You will need to have the [Scala IDE for Eclipse](http://scala-ide.org/) installed. There is a link in the See also section with instructions how to accomplish this.

To create the project files for Eclipse, add the following to `plugins.sbt`, which can be found in the `project` directory:

```scala
addSbtPlugin("com.typesafe.sbteclipse" % "sbteclipse-plugin" % "2.0.0")
```

You can then create Eclipse project files within SBT by entering the following: 

```scala
eclipse
```

In Eclipse, navigate to File -> Import.. and select "General > Existing Projects into Workspace".  Navigate to and select your Lift project.  You are now set up to develop you application in Eclipse.

Run SBT while you are editing to handle reloads of the web container. Start `sbt` from a terminal window outside of Eclipse and enter the following:

```scala
~; container:start; container:reload /
```

You can then edit in Eclipse, and in your web browser hit reload to see the change.

Discussion
----------

You can also force the SBT `eclipse` command to download the Lift source.  This will allow you to click through to the Lift source from methods and classes.  To achieve this once, run `eclipse with-source=true`, but if you want this to be the default behaviour, add the following to your `build.sbt` file:

```scala
EclipseKeys.withSource := true
```

If you find yourself using the plugin frequently, you may wish to set it in your global SBT configuration files: `~/.sbt/plugins/build.sbt` for the module definition and `~/.sbt/user.sbt` for any settings.

The restarting of the web container isn't always as efficient as you'd like.  This can often be avoided by using JRebel, which will be the subject of a future recipe.


See also
--------

* [ScalaIDE download](http://scala-ide.org/download/current.html)
* [Using the sbteclipse plugin](https://github.com/typesafehub/sbteclipse/wiki/Using-sbteclipse)
* [SBT Triggered Execution](https://github.com/harrah/xsbt/wiki/Triggered-Execution)
* [SBT Command Line Reference](https://github.com/harrah/xsbt/wiki/Command-Line-Reference)
* [SBT Web Plugin Commands](https://github.com/siasia/xsbt-web-plugin/wiki)
* [JRebel](http://zeroturnaround.com/jrebel/)

