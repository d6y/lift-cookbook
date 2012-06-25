Implementing custom validation logic
====================================

Problem
-------

You want to provide your own validation logic and apply it to a field in a record.

Solution
--------

Implement a function from the type of field you want to validate to `List[FieldError]`. Perhaps we want to ensure that no-one added to the database can have the same name, so we need to provide a `String => List[FieldError]` function:

```scala
class Person private () extends Record[Person] with KeyedRecord[Person] {

  override def meta = Person

  @Column(name = "id")
  override val idField = new LongField(this)
 
  val name = new StringField(this, 100) {
    override def validations = 
      valUnique("Please change your name") _ :: super.validations
  }
  
  def valUnique(errorMsg: ⇒ String)(name: String): List[FieldError] = 
    Person.byName(name) match {
      case Some(name) => FieldError(this.name, errorMsg) :: Nil
      case _ => Nil
  }

}
```


Discussion
----------

By convention validation functions have two argument lists: the first for the error message; the second to receive the value to validate.  This allows you to easily re-use your validation function on other fields.

The `FieldError` you return needs to know the field it applies to as well as the message to display.  In the example the field is `name`, but we've used `this.name` to avoid confusion with the `Some(name)` in the pattern match or the `name` passed as an argument to `valUnique`.

In case you're wondering, the implementation of `Person.byName` might be:

```scala
def byName(name: String) = 
  from(YourSchema.people)
  (p => where(lower(p.name) === lower(name)) 
  select (l)).headOption
```


See Also
--------

* Source for [BaseField.scala](https://github.com/lift/framework/blob/master/core/util/src/main/scala/net/liftweb/util/BaseField.scala) which includes the definition of `StringValidators`.

