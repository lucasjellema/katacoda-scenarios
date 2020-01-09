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

