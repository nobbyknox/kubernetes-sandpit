const http = require('http');

const handleRequest = function(request, response) {
  console.log('Received request for URL: ' + request.url);
  response.writeHead(200);
  response.end(process.env.HELLO_MESSAGE || 'Hello World!');
};

const www = http.createServer(handleRequest);

www.listen(8080);

console.log('server.js version "2017-09-08 12:00" started');
