AppIOS
======

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

AppIOS Infrastructure for an iOS App using SQLite.
This is included as a Submodule in ABExample.
Contains infrastructure to access an SQLite DB effiecently and easily.
The SQLite database can use the standard 'libsqlite3.0.dylib' or if you want to run SQLCipher replace
this library with libsqlcipher-ios.a, and use their <sqlite3.h> also comment in the #ifdef ENCRYPT.
The third README.md file explains in detail on how to change from SQLite to SQLCipher.

A typical short SQL Query looks like:

For selects
NSMutableArray = GetRecordsForQuery:@"select firstName, lastName from Company where lastName = ? ",@"Smith",nil];

OR
For inserts, deletes or updates

BOOL = ExecuteStatement:@"insert into Company (firstName, lastName) values(?,?)",@"John",@"Smith", nil];

In addition complex SQL Queries can be created with NSMutableArray's containing the parameters, and NSMutableString's
containing the SQL Query statements. 

SQL Transactions are also supported by loading an NSMutableArray of SQL NSDictionary's statements so that they 
very efficient and quick inserts can be performed for large data sets. Transactions come in very handy when you 
try to insert say a user's Contact's from their iPhone and they have 30,000 of them.


