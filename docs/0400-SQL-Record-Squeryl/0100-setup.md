
===========

Problem
-------

You want use Record with Squeryl.


Solution
--------

Boot.scala

```scala
  def db = {
    Class.forName("org.h2.Driver")

    SquerylRecord.initWithSquerylSession(Session.create(DriverManager.getConnection("jdbc:h2:mem:dbname;DB_CLOSE_DELAY=-1", "sa", ""), new H2Adapter))

  }
```

``` scala

object Mychema extends Schema {

  /** list of Object/tables mappings.*/	
  val tags = table[Tag]

    
}

```

Using 
``` scala
    import net.liftweb.squerylrecord.RecordTypeMode._
    import IDTPSchema._

    val all = from(tags, tags)((c, e) ⇒ select((c, e)))

    inTransaction {
      all.map { logger.info(_) }
    }

    val t = Tag.createRecord.reference(System.currentTimeMillis().toString()).physicalUID(System.currentTimeMillis().toString()).contentMimeType("text").content("".getBytes())

    inTransaction {
      tags.insert(t)
    }

    val again = from(tags, tags)((c, e) ⇒ select((c, e)))

    inTransaction {
      again.map { logger.info(_) }
    }
```


Discussion
----------



See Also
--------
* Squeryl page on [lift wiki](http://www.assembla.com/wiki/show/liftweb/Squeryl).
* Squeryl [sessions and transactions] (http://squeryl.org/sessions-and-tx.html) page.
* Squeryl [getting started](http://squeryl.org/getting-started.html) page.



