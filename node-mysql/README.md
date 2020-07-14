# Node.js MySQL tutorial

<https://www.w3schools.com/nodejs/nodejs_mysql.asp>

Download MySQL: <https://dev.mysql.com/downloads/mysql>

Download `mysql` CLI shell: <https://dev.mysql.com/downloads/shell>

<https://dev.mysql.com/doc/mysql-osx-excerpt/8.0/en/osx-installation-pkg.html>

<https://dev.mysql.com/doc/mysql-osx-excerpt/8.0/en/osx-installation-launchd.html>

```bash
# npm init
npm install mysql
node demo_db_connection.js
```

And in your `.bash_profile`:

```bash
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
```

```js
// demo_db_connection.js
var mysql = require("mysql");

var con = mysql.createConnection({
  host: "localhost",
  user: "yourusername",
  password: "yourpassword",
});

con.connect(function (err) {
  if (err) throw err;
  console.log("Connected!");
});
```

## Things to try if you get the `ER_NOT_SUPPORTED_AUTH_MODE` error

### Useful commands to start/stop/restart MySQL server

- `sudo /usr/local/mysql/support-files/mysql.server start`
- `sudo /usr/local/mysql/support-files/mysql.server stop`
- `sudo /usr/local/mysql/support-files/mysql.server restart`

### Reset root password

<https://github.com/mysqljs/mysql/issues/1507>

```bash
mysql -p
# then in mysql> :
use mysql;
set password for 'root'@'localhost' = 'YourNewRootPassword';
flush privileges;
quit;
```

or:

```bash
mysql -p
# then in mysql> :
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'YourNewRootPassword';
quit;
```
