Automatic created and updated timestamps for a Squeryl Record
=============================================================

Problem
-------

You want created and updated fields on your records and would like them automatically updated when a row is added or updated.

Solution
--------

Define the following traits:

```scala
trait Created[T <: Created[T]] extends Record[T] {
  self: T =>
  val created: DateTimeField[T] = new DateTimeField(this) { 
    override def defaultValue = Calendar.getInstance
  }
}

trait Updated[T <: Updated[T]] extends Record[T] {
  self: T =>

  val updated = new DateTimeField(this) { 
    override def defaultValue = Calendar.getInstance
  }

  def onUpdate = this.updated(Calendar.getInstance)

}

trait CreatedUpdated[T <: Updated[T] with Created[T]] extends 
  Updated[T] with Created[T] { 
    self: T => 
}
```

Add to your model, for example: 

```scala
class YourRecord private () extends Record[YourRecord] 
  with KeyedRecord[Long] with CreatedUpdated[YourRecord] {
    override def meta = YourRecord
    //field entries ...
}
```

Finally, arrange for the `updated` field to be updated:

```scala
class YourSchema extends Schema {
  ...
  override def callbacks = Seq(       
    beforeUpdate[YourRecord] call {_.onUpdate} 
  ) 
  ... 
```

Discussion
----------

_This recipe requires Lift 2.5 or later._

Although there is a built in `net.lifetweb.record.LifecycleCallbacks` trait in which allows you trigger behaviour onUpdate, afterDelete and so on, it is only for use on individual Fields, rather than Records. As our goal is to update the `updated` field when any part of the Record changes, we can't use the `LiftcycleCallbacks` here.

Instead, the `CreatedUpdated` trait simplifies adding an `updated` and `created` fields to a Record, but we do need to remember to add a hook into the schema to ensure the `updated` value is changed when a record is modified.  This is why we set the `callbacks` on the Schema.

It should be noted that `onUpdate` is only called on full updates and not on partial updates with Squeryl. A full update is when the object is altered and then saved; a partial update is where you attempt to alter many objects via a query. 

If you're interested in other automations for Record, the Squery schema callbacks also support other triggered behaviours:

* `beforeInsert` and `afterInsert`
* `afterSelect`
* `beforeUpdate` and `afterUpdate`
* `beforeDelete` and `afterDelete`


See Also
--------

* [Explanation of full vs partial update in Squeryl](http://squeryl.org/inserts-updates-delete.html).
* Mailing list discussion [regarding LifecycleCallbacks](https://groups.google.com/d/msg/liftweb/G4U14pQbZZ4/V24YvhUPvEEJ).
