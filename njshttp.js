// Load the http module to create an http server.
var http = require('http');

var spawn = require('child_process').spawn;

// Configure our HTTP server to respond with Hello World to all requests.
var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  var candump = spawn('/usr/bin/candump',['-T', '60000', 'can0']);

  candump.stdout.on('data', function (data) {
    response.write(data.toString());
  });

  candump.stderr.on('data', function (data) {
    response.write(data.toString());
  });

  candump.on('exit', function (code) {
    console.log('child process exited with code ' + code.toString());
    response.end("END");
  });

});

// Listen on port 8000
server.listen(8000, "0.0.0.0");

// Put a friendly message on the terminal
console.log("Server running at http://0.0.0.0:8000/");
