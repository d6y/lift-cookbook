# Changes to files since first edition


# 00-Preface.asciidoc

* Added Chenguang He as a contributor.

* Noted that we are now using SBT 0.13, Scala 2.11 and Lift 2.6


# 01-Installing-and-Running.asciidoc

* UPDATE: SBT web plugin home and version
* UPDATE: version bumps for IntelliJ SBT plugin.
* CORRECTION: "want want" -> "want", from  Jie Liu: https://github.com/d6y/lift-cookbook/pull/60
* UPDATE: SBT 0.13, Lift 2.6
* UPDATE: IntelliJ version 12 -> 13

# 02-HTML.asciidoc

* UPDATE: Noticed that CSS class can be used to invoke a snippet.

# 03-Forms.asciidoc

* NOTE: "Making Suggestions with Autocomplete": Added a note box, "jQuery 1.9", on dealing with methods removed from jQuery in their 1.9 release. {For RD: cookbook_forms example source code has been updated to include this}

* NEW RECIPE: "DRY Forms with Layout", using CssBoundLiftScreen. From Tony Kay.


# 04-REST.asciidoc

* NEW RECIPE: Streaming video.

* Correction: the "text" and "by" values given in the Discussion for "Returning JSON" were swapped.

* Update for Lift 2.6: removed deprecation warning from REST Sitemap example.


# 05-JavaScript-Ajax-Comet.asciidoc

# 06-Pipline.asciidoc

* FORMATTING: "Streaming Content", the section on `StreamingResponse`, formatting error in the para
starting "Notice...", where the "java.io.InputStream-like" CW font wasn't closing because of the "-".

* Extended: "Force HTTPS Requests" now has a section on "via SiteMap"

# 07-Record-Squeryl.asciidoc


*

# 08-Mapper.asciidoc

NB: 08-Mapper chapter still to be omitted.


# 09-Record-Mongo.asciidoc

* NOTE: "Unit Testing Record with MongoDB": added a note box, "Specs2 2.x and Scala 2.10", on how to use MongoTestKit with Scala 2.10 and Specs2 2.1. {For RD: cookbook_mongo example source code changes made in scala-2.10 branch}






# 10-Around.asciidoc

* CORRECTION: The recipe for "HTML Email" had the title "SMTP Authentication".

* Additional clues: Don't use DateTime as a delay for a scheduled action.


# 11-Deployment.asciidoc

* NOTE added: CloudBees is closing hosting at the end of 2014.


# 12-Contributing.asciidoc
