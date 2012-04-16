Sequence numbers and existing data
==================================

Problem
-------

You have a table with data in it, but Lift inserts new records with a primary key starting from 1, or some other value that may already exist.

Solution
--------

Work with the native sequence facility in your database to set the starting sequence value to be the value you want Lift to use.

The first step is to work out what value you want the sequence to start from.  Most likely this will be just after the largest primary key ID in the table you're working with.  With PostgreSQL, for example, you can check this via the `psql` command:

```sql
SELECT MAX(id) FROM mytable;
```

To find out what sequences exist, run `\ds` in `psql`.  The sequence to change will contain the name of your table. You can then change the value:

```sql
ALTER SEQUENCE mytable_id_seq RESTART WITH 1000;
```

Discussion
----------

Lift defers to the database sequence facility to generate primary key values.  If you insert data by-passing the sequence, the sequence value will not know about the specific primary key values you have used (this is not Lift-specific).  The solution above resolves this by updating the starting sequence number to skip over the rows that already exist in your database.

The same instructions apply for using Record as well as Mapper.

See Also
--------

* Mailing list discussion "[Mapper starts counting primary keys with key 1 in a non-empty table](https://groups.google.com/forum/?fromgroups#!topic/liftweb/eAelsvlFkaI)".
* PostgreSQL [Sequence Manipulation Functions](http://www.postgresql.org/docs/9.1/static/functions-sequence.html).
* MySQL [AUTO-INCREMENT](http://dev.mysql.com/doc/refman/5.6/en/example-auto-increment.html) describes how to use ALTER TABLE to change the sequence value.
* [Updating ORACLE sequence](http://www.techonthenet.com/oracle/sequences.php) involves changing the incrementing step to cover the values to skip.
