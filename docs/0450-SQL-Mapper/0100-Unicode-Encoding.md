Unicode Encoding (Charset) (MySQL)
========================

Problem
-------

On your Boot class you have

    LiftRules.early.append(_.setCharacterEncoding("UTF-8"))

and your database collation is all correct for tables and columns. But if you enter Chinese characters using Lift, they
are stored as ???


Solution
--------

Add

    ?useUnicode=true&characterEncoding=UTF-8

to your jdbc connection url

Discussion
----------

[EMail thread on the Lift mailing list](https://groups.google.com/forum/?fromgroups#!topic/liftweb/DL9AFyU5y2k)

