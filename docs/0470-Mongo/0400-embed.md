
Embedding a document inside a Mongo record
================================

Problem
-------

You have a Monogo record, and you want to embed another set of values inside it as a single entity.


Solution
--------

Use `BsonRecord` to define the document to embed, and embed it using `BsonRecordField`.  Here's an example of storing information about an image within a record:

```scala
class Image private () extends BsonRecord[Image] {
  def meta = Image
  object url extends StringField(this, 1024)
  object width extends IntField(this)
  object height extends IntField(this)
}

object Image extends Image with BsonMetaRecord[Image]
```

We can reference instances of the `Image` class via `BsonRecordField`:

```scala

class Country private () extends MongoRecord[Country] with StringPk[Country] {
  override def meta = Country
  object flag extends BsonRecordField(this, Image)
}

object Country extends Country with MongoMetaRecord[Country] {
  override def collectionName = "example.earth"
}
```

To associate a value:

```scala
val unionJack = 
  Image.createRecord.url("http://bit.ly/unionflag200").width(200).height(100)

uk.createRecord.id("uk").flag(unionJack).save(true)
```

In Mongo, the resulting data structure would be:

```
> db.example.earth.findOne()
{
  "_id" : "uk",
  "flag" : {
    "url" : "http://bit.ly/unionflag200",
    "width" : 200,
    "height" : 100
  }
}
```


Discussion
----------

If you don't set a value on the embedded document, the default will be saved as:

```
"flag" : { "width" : 0, "height" : 0, "url" : "" } 
```

You can prevent this by making the image optional:

```scala
object image extends BsonRecordField(this, Image) {
  override def optional_? = true
}
```

With `optional_?` set in this way the image part of the Mongo document won't be saved if the value is not set.  Within Scala you will then want to access the value with `valueBox` call:

```scala
val img : Box[Image] = uk.flag.valueBox
```

In fact, regardless of the setting of `optional_?` you can access the value using `valueBox`.


An alternative is to always provide a default value for the embedded document:

```scala
object image extends BsonRecordField(this, Image) {
 override def defaultValue = 
  Image.createRecord.url("http://bit.ly/unionflag200").width(200).height(100)
}
```


See Also
--------

* [Mongo Record Embedded Objects
](https://www.assembla.com/spaces/liftweb/wiki/Mongo_Record_Embedded_Objects) on the Lift Wiki.


