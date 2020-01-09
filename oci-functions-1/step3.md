# Invoke Function with CURL 

In this step we will invoke the function with CURL. Subsequently, we will take a look at the context data available to the function when it is handling a request.

## Getting a Function's Invoke Endpoint

In addition to using the Fn invoke command, we can call a function by using a URL. To do this, we must get the function's invoke endpoint. Use the command fn inspect function <appname> <function-name>. To list the nodefn function's invoke endpoint we can type:

`fn inspect f nodeapp hello`{{execute}}

Get the value from the annotation `fnproject.io/fn/invokeEndpoint` in the result of this inspect command. 

You can invoke the function using *curl* at this endpoint. Please set an environment variable HELLO_FUNCTION_ENDPOINT with the value from the endpoint.  

`export HELLO_FUNCTION_ENDPOINT=<the invokeEndpoint>`{{execute}}

Now with the variable set you should be able to invoke the function using curl:

`curl -X "POST" -H "Content-Type: application/json" -d '{"name":"Bob"}' $HELLO_FUNCTION_ENDPOINT`{{execute}}


## Context available to a Function when processing a Request.

Click on the file func.js to open it in the editor.

Add a input parameter to the function definition on line 3, to make this line read:

<pre class="file" data-target="clipboard">
   fdk.handle(function(input , ctx){
</pre>

The FDK framework will pass the request context in this variable. 

Change line 8 to make it read: 

<pre class="file" data-target="clipboard">
  return {'message': 'Hello ' + name ,'ctx':ctx}
</pre>

Changes to file func.js are saved automatically by the editor - do not look for a Save button or use Ctrl+S.

Now we need to redeploy the function with the same command as before:

`fn -v deploy --app nodeapp --local `{{execute}}

And invoke it, either through Fn:

`echo -n '{"name":"Your Own Name"}' | fn invoke nodeapp hello --content-type application/json`{{execute}}


Or using CURL.

`curl -X "POST" -H "Content-Type: application/json" -H "my-special-header: my-value" -d '{"name":"Johanna"}' $HELLO_FUNCTION_ENDPOINT`{{execute}}

The custom header should now be visible in the response from the function because it is visible in the context sent to the function by Fn.

By inspecting the *ctx* input parameter, you can make your function interpret the request in a more encompassing way than by only inspecting the input parameter. 



## Resources 
Check out this article for details about the contents of the Fn request context:(Oracle Cloud Infrastructure Functions and Project Fn – Retrieving Headers, Query Parameters and other HTTP Request elements)[https://technology.amis.nl/2020/01/02/oracle-cloud-infrastructure-functions-and-project-fn-retrieving-headers-query-parameters-and-other-http-request-elements/] 

