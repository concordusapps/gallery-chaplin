var http = require('http'),
    httpProxy = require('http-proxy');

//
// Create a new instance of HttProxy to use in your server
//
var proxy = new httpProxy.RoutingProxy();

//
// Create a regular http server and proxy its handler
//
http.createServer(function (req, res) {
  req.headers.host = 'fabric-ocean.herokuapp.com';
  proxy.proxyRequest(req, res, {
    host: 'fabric-ocean.herokuapp.com',
    port: 80
  });
}).listen(8001);
