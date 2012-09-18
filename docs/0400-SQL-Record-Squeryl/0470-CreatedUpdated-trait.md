Create and update trait for record
=====================================

Problem
-------

You want created and updated fields on your records and would like them automatically updated when a row is added or updated.

Solution
--------
Define the following traits:

```scala
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

Add to your model and schema: 

```scala
def  consumerCallbacks = Seq( beforeUpdate[Consumer] call {_.onUpdate})

class Consumer private () extends MongoRecord[Consumer] with ObjectIdPk[Consumer] with CreatedUpdated[Consumer] {
  override def meta = Consumer
  //field entries ...
}
```


Discussion
----------

The default value sets our created date and `onUpdate` on `Updated` allows the field to have the latest timestamp. 

It should be noted that `onUpdate` is only called on full updates and not on partial updates when using Squeryl. A full update is when the object is altered and then saved, a partial is where you attempt to alter many objects via a query. 

See Also
--------

* [Explaination of full Vs partial update in squeryl](http://squeryl.org/inserts-updates-delete.html)

