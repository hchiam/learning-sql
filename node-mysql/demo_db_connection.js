var mysql = require("mysql");

var connection = mysql.createConnection({
  host: "localhost",
  user: "yourusername",
  password: "yourpassword",
});

connection.connect(function (err) {
  if (err) throw err;
  console.log("Connected!");
});
