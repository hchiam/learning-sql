# Node.js MySQL tutorial

<https://www.w3schools.com/nodejs/nodejs_mysql.asp>

Download MySQL: <https://dev.mysql.com/downloads/mysql>

```bash
# npm init
npm install mysql
node demo_db_connection.js
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
