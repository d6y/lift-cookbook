
Connecting to a Mongo database
=========================

Problem
-------

You want to connect to a MongoDB.

Solution
--------

Configure your connection using `net.liftweb.mongodb` and `com.mongodb` in `Boot.scala`:

```scala
import com.mongodb.{ServerAddress, Mongo}
import net.liftweb.mongodb.{MongoDB,DefaultMongoIdentifier}

val srvr = new ServerAddress("127.0.0.1", "20717")
MongoDB.defineDb(DefaultMongoIdentifier, new Mongo(srvr), "mydb")
```

This will give you a connection to a local MongoDB database called "mydb".


Discussion
----------

If your database needs authentication, use `MongoDB.defineDbAuth`:

```scala
MongoDB.defineDbAuth(DefaultMongoIdentifier, new Mongo(srvr), 
  "mydb", "username", "password")
```

Some cloud services will give you a URL to connect to, such as "alex.mongohq.com:10050/fglvBskrsdsdsDaGNs1".  In this case, the host and the port make up the first part, and the database name is the part after the `/`.


See Also
--------

* [Mongo Configuration](https://www.assembla.com/wiki/show/liftweb/Mongo_Configuration) on the wiki contains more details and options, including configuration for replica sets.





