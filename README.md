# Mark's Snippets

## Azure Data Studio snippets

### What the snippets do

- `ctd`: stands for "create test database". This snippet is to help create a rerunnable script that creates a database in a specific state. Given a database name, it will drop that database if it exists, create a database with that name, and at the end switch back to master so there's no connection to the database that's just been made.
- `c2td`: stands for "create 2 test databases". Same as above, but creates two databases, one with a suffix `_Source` and one with a suffix `_Target`.

### How to install

If you don't have any existing snippets, just copy `ads-snippets/sql.json` to `%APPDATA%\azuredatastudio\User\snippets`. If you do have existing snippets, you'll need to merge those files.

### How to use

In a query window:
- Type `ctd`, Enter
- Type the name of the database
- Press Tab
- Write your SQL to create the database schema

## SQL Developer code templates

### What the snippets do

- `cts`: stands for "create test schema". Much the same as "create test database" in the ADS snippets, but for an Oracle schema instead of a SQL Server database.
- `c2ts`: stands for "create 2 test schemas". Same as above, but creates two schemas, one with a suffix `_A` and one with a suffix `_B`.

### How to install

In SQL Developer:

- Tools -> Preferences -> Code Editor -> Code Templates
- Add Template
- Edit the name on the left, to eg `cts`
- On the right, click the pencil icon to open the editor
- Paste in the contents of eg `sql-developer-templates/cts.sql`
- Close
- OK

### How to use

In a SQL worksheet:
- Type `cts`
- In theory, pressing Ctrl+Space will complete the snippet, but I find that only actually works ~20% of the time
- Double clicking on the preview of the snippet seems to always work though
