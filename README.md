# Lift Cookbook

Source for a prototype "Lift Cookbook" at http://liftcookbook.spiralarm.cloudbees.net/

To contribute to this text, see [How to add a new recipe](http://liftcookbook.spiralarm.cloudbees.net/How+to+add+a+new+recipe+to+this+Cookbook.html).  New and updated pages are noted via [@LiftCookbook](https://twitter.com/#!/liftcookbook).

## How to Generate HTML

We're using Pamflet to generate the HTML. There are two ways to invoke Pamflet.

### Command Line

Install [_cs_ and then _pf_](http://pamflet.databinder.net/Combined+Pages.html#On+the+Command+Line
) to preview the content of _docs/_ on your local machine.

### SBT Plugin

Requires SBT 0.11.0

Simply start SBT and run `start-pamflet` to start the server for live viewing or `write-pamflet` to generate the HTML.

## Todo:

* decide if this is a dumb idea or not.
* Find out how to link between sections with Pamflet/markdown.




