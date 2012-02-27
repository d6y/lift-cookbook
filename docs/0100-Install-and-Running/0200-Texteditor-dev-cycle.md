Developing using a text editor
==============================

Problem
-------

You want to develop your Lift application using your favourite text editor, hitting reload in your browser to see changes.

Solution
---------

Run SBT while you are editing to handle compilation of Scala files.  

Start `sbt` and enter the following:

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
