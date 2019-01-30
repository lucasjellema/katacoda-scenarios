Allow a code block to be copied `some-command`{{copy}}

<pre class="file" data-filename="docker-compose.yml" data-target="replace">
var http = require('http');
var requestListener = function (req, res) {
  res.writeHead(200);
  res.end('Hello, World!');
}

var server = http.createServer(requestListener);
server.listen(3000, function() { console.log("Listening on port 3000")});
</pre>
          
<pre class="file" data-filename="docker-compose.yml" data-target="append">
var server2 = http.createServer(requestListener);
server2.listen(4000, function() { console.log("Listening on port 4000")});
</pre>

<pre class="file" data-target="clipboard">Test</pre>
          

<pre class="file" data-target="regex???">Test</pre>