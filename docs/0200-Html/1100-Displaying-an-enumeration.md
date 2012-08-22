Displaying an enumerated type in Form
=================================

Problem
-------

You would like to display an enumerated value within a form.

Solution
--------

If you don't require I18N and are happy to use the labels used in the Enumeration.


```scala
	var default: MyEnum.Value = MyEnum.valueA

	".enum *" #> SHtml.selectElem(MyEnum.values.toList, Full(default))(default = _) &
```

If I18N or localisation are requirements, an impilicit conversion from `Enumeration Value` to localised String is required. The localised String value is keyed by the enumeration string value. 

```scala
	/** define enumeration. */
    object MyEnum extends Enumeration("myenum.valueA","myenum.valueB") {
  		type MyEnum = Value

  		val valueA,valueB = Value
	}
```
In the above snippet, "myenum.valueA" will be used as the bundle key for the localised content.


```
	/**  define implicits for enumeration */
	object EnumerationImplicits {

	  type EnumerationValue = Enumeration#Value

	  implicit def enumToStrValPromo[EnumerationValue]: SHtml.PairStringPromoter[EnumerationValue] =
	    new SHtml.PairStringPromoter[EnumerationValue]{ def apply(in: EnumerationValue): String = S.?(in.toString) }
	}	
```

With the Implicit defined and imported, the selectElem function can be used.

```
	/** Use the snippet. */
    import EnumerationImplicits.enumToStrValPromo

    var default: MyEnum.Value = MyEnum.valueA

	".enum *" #> SHtml.selectElem(MyEnum.values.toList, Full(default))(default = _) &


```

Discussion
----------


See Also
--------

 * [Comments by dpp on why the implicit conversion is needed](https://groups.google.com/forum/?fromgroups=#!searchin/liftweb/enumToStrValPromo/liftweb/9WgCpD8__wQ/CzzxBxLaeYMJ)

