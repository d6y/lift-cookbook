Secure requests only 
===================

Problem
-------

You want to ensure clients are using https. 

Solution
--------

Add an `earlyResponse` function in `Boot.scala` redirecting insecure requests.  For example:

```scala
LiftRules.earlyResponse.append { (req: Req) ⇒ if (req.request.scheme != "https") {
  val uriAndQueryString = req.uri + (req.request.queryString.map(s => "?"+s) openOr "")
  val uri = "https://%s%s".format(req.request.serverName, uriAndQueryString)
  Full(PermRedirectResponse(uri, req, req.cookies: _*))
} else Empty }
```

Discussion
----------

The `earlyResponse` call is called early in the Lift pipeline. It is used to excute code before a request is handled and if required exit the pipeline and return a response.  The function signature it expects is `Req ⇒ Box[LiftResponse]`.

The ideal method to ensure requests are served using the correct scheme would be via web server configuration, such as Apache or Nginx. This isn't possible in some cases, such as when your application is deployed to a PaaS, for instance CloudBees.

### Amazon Load Balancer

For Amazon Elastic Load Balancer note that you need to use `X-Forwarded-Proto` header to detect HTTPs.  As mentioned in their _Overview of Elastic Load Balancing_ document, "Your server access logs contain only the protocol used between the server and the load balancer; they contain no information about the protocol used between the client and the load balancer."  In this situation modify the above test from `req.request.scheme != "https"` to:

```scala
req.header("X-Forwarded-Proto") != Full("https")
```


See Also
--------

* Source code for [LiftRules.scala](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/http/LiftRules.scala).
* [Req.scala](https://github.com/lift/framework/blob/master/web/webkit/src/main/scala/net/liftweb/http/Req.scala) source.
* [Lift pipeline](https://www.assembla.com/spaces/liftweb/wiki/HTTP_Pipeline).
* @fmpwizard observations and solution for [Redirect http to https behind Amazon load balancer](https://groups.google.com/d/msg/liftweb/204aAsVb_4Y/I1BiLKkrTPIJ).
* [Overview of Elastic Load Balancing](http://docs.amazonwebservices.com/ElasticLoadBalancing/latest/DeveloperGuide/arch-loadbalancing.html) at AWS.