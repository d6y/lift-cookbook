Catch any exception
===================

Problem
-------

You want a wrapper around all requests to catch exceptions and display something to the user.

Solution
--------

Declare an exception handler in `Boot.scala`:

```scala
LiftRules.exceptionHandler.prepend {
  case (runMode, request, exception) =>           
  	logger.error("Boom! At "+request.uri)
  	InternalServerErrorResponse()
}
```

In the above example, all exceptions for all requests at all run modes are being matched, causing an error to be logged and a 500 (internal server error) to be returned to the browser.

Discussion
----------

The partial function you define `exceptionHandler` needs to return a `LiftResponse` (i.e., something to send to the browser).  The default behaviour is to return an `XhtmlResponse`, which in `Props.RunModes.Development` gives details of the exception, and in all other run modes simply says "Something unexpected happened".

You can return any kind of `LiftResponse`, including `RedirectResponse`, `JsonResponse`, `XmlResponse`, `JavaScriptResponse` and so on.

This second example shows matching on Ajax requests only, and returning a JavaScript dialog to the browser:

```scala
import net.liftweb.http.js.JsCmds._

val ajax = LiftRules.ajaxPath

LiftRules.exceptionHandler.prepend {
  case (mode, Req(ajax :: _, _, PostRequest), ex) => 
    logger.error("Error handing ajax")
    JavaScriptResponse(Alert("Boom!"))
}
```

This Ajax example will jump in before Lift's default behaviour for Ajax errors.  The default is to retry the Ajax command three times (`LiftRules.ajaxRetryCount`), and then execute `LiftRules.ajaxDefaultFailure`, which will pop up a dialog saying: "The server cannot be contacted at this time"


See Also
--------

* [Source for LiftRules.scala](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/http/LiftRules.scala)
* [Source for LiftResponse.scala](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/http/LiftResponse.scala)
* [Mailing list discussion on JS dialogs for exceptions](http://groups.google.com/group/liftweb/browse_thread/thread/842954ffc333b0f9)


