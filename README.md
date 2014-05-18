AppIOS
======

AppIOS Infrastructure for an iOS App using SQLite.
Contains infrastructure to access an SQLite DB effiecently and easily.
The SQLite database can use the standard 'libsqlite3.0.dylib' or if you want to run SQLCipher replace
this library with libsqlcipher.a, and use their <sqlite3.h> also comment in the #ifdef ENCRYPTION.
A typical short SQL Query looks like:
For selects
NSMutableArray = GetRecordsForQuery:@"select firstName, lastName from Company where lastName = ? ",@"Smith",nil];
OR
For inserts, deletes or updates
BOOL = ExecuteStatement:@"insert into Company (firstName, lastName) values(?,?)",@"John",@"Smith", nil];
In addition complex SQL Queries can be created with NSMutableArray's containing the parameters, and NSMutableString's
containing the SQL Query statements. 
SQL Transactions are also supported by loading an NSMutableArray of SQL statements so that very efficient
and quick inserts can be performed for large data sets.


