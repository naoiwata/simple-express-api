Simple API by NodeJS/Express
==============================

A simple rest API for setting/getting JSON file.

========
Install
========

.. sourcecode:: sh

   $ make init

========
Usage
========

Run Server
-------------

.. sourcecode:: sh

   $ make run

Use Curl
----------

.. sourcecode:: sh
    
   ## create <status>.json includes {<key>: <value>}
   $ curl http://127.0.0.1:3000/api/status -D - -X POST --data '{"mode": 1}' -H "Content-type: application/json"
   HTTP/1.1 200 OK
   X-Powered-By: Express
   Content-Type: application/json; charset=utf-8
   Content-Length: 10
   Date: Wed, 25 Jun 2014 09:35:05 GMT
   Connection: keep-alive

   {"mode":1}

   ## get <status>.json
   $ curl http://127.0.0.1:3000/api/status -D - -X GET
   HTTP/1.1 200 OK
   X-Powered-By: Express
   Content-Type: application/json; charset=utf-8
   Content-Length: 10
   ETag: W/"a-2125303275"
   Date: Wed, 25 Jun 2014 09:35:35 GMT
   Connection: keep-alive

   {"mode":1}

   ## update
   $ curl http://127.0.0.1:3000/api/status -D - -X POST --data '{"mode": 2}' -H "Content-type: application/json"
   HTTP/1.1 200 OK
   X-Powered-By: Express
   Content-Type: application/json; charset=utf-8
   Content-Length: 10
   Date: Wed, 25 Jun 2014 09:35:55 GMT
   Connection: keep-alive

   {"mode":2}%

   ## add another key to <status>.json
   $ curl http://127.0.0.1:3000/api/status -D - -X POST --data '{"guest": true}' -H "Content-type: application/json"
   HTTP/1.1 200 OK
   X-Powered-By: Express
   Content-Type: application/json; charset=utf-8
   Content-Length: 23
   Date: Wed, 25 Jun 2014 09:36:11 GMT
   Connection: keep-alive

   {"mode":2,"guest":true}%

   ## delete key to <status>.json
   $ curl http://127.0.0.1:3000/api/status/mode -D - -X DELETE
   HTTP/1.1 200 OK
   X-Powered-By: Express
   Content-Type: application/json; charset=utf-8
   Content-Length: 14
   Date: Wed, 25 Jun 2014 09:36:30 GMT
   Connection: keep-alive

   {"guest":true}

Use $.ajax
------------

.. sourcecode:: javascript

   // GET
   $.ajax({
     type: 'GET'
     url:'http://127.0.0.1:3000/api/<key>'
   }).done(function(res){
     // success
   });

   // POST
   $.ajax({
     type: 'POST',
     url:'http://127.0.0.1:3000/api/<key>',
     data: '{"bar":"hoge"}',
     headers: {
       'Content-Type': 'application/json'
     }
   }).done(function(res){
     // success
   });

   // DELETE
   $.ajax({
     type: 'DELETE',
     url:'http://127.0.0.1:3000/api/<key>/<json_key>'
   }).done(function(res){
     // success
   });

========
Test
========

.. sourcecode:: sh
    
   $ make tests
