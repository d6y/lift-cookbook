Create and Update trait for squerly record
=====================================

Problem
-------

You want created and updated fields on your tables and would like them automatically updated when a row is added or updated.

Solution
--------

Use the following traits.

```scala

// add the following to the schema. 
  def  consumerCallbacks = Seq( beforeUpdate[Consumer] call {_.onUpdate})

//trait action
trait Created[T <: Created[T]] extends Record[T] with Loggable {

  self: T ⇒

  val created: DateTimeField[T] = new DateTimeField(this){ override def defaultValue = Calendar.getInstance() }
  
}

trait Updated[T <: Updated[T]] extends Record[T] with Loggable {

  self: T ⇒

  val updated = new DateTimeField(this){ override def defaultValue = Calendar.getInstance()}

  def onUpdate = this.updated(Calendar.getInstance)


}


trait CreatedUpdated[T <: Updated[T] with Created[T]] extends Updated[T] with Created[T] { 
  self: T =>
  
}
```

Discussion
----------

The default value sets our created date and `onUpdate` on `Updated` allows the field to have the latest timestamp. It should be noted that `onUpdate` is only called on full updates and not on partial updates. 
A full update is when the object is altered and then saved, a partial is where you attempt to alter many objects via a query. 

See Also
--------

* [Explaination of full Vs partial update in squeryl](http://squeryl.org/inserts-updates-delete.html)

