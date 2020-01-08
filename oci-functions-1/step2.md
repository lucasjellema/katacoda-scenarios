# Creating a Function with Fn 

In this step we will create a simple function with Fn. We pick Node (JS) as our runtime - Go, Python, Java and Ruby are other out of the box options.

`fn init --runtime node hello`{{execute}}

`cd hello`{{execute}}

Three files have been created in the new directory *hello*.

`ls`{{execute}}

You could open func.js in the text editor to see the generated functionality.

Create an Fn application - a container for multiple related functions:  

`fn create app nodeapp`{{execute}}

Deploy the Function Hello locally, into the app that was just created

`fn -v deploy --app nodeapp --local `{{execute}}

Verify that a Docker Container Image has been built for Fn Function Hello:

`docker images | grep something-meaningless`{{execute}}

Time to invoke the function. The command for invoking the function is simply: `fn invoke <app-name> <function-name>`:

`fn invoke nodeapp hello`{{execute}}

`echo -n '{"name":"Your Own Name"}' | fn invoke nodeapp hello --content-type application/json`{{execute}}

## Getting a Function's Invoke Endpoint

In addition to using the Fn invoke command, we can call a function by using a URL. To do this, we must get the function's invoke endpoint. Use the command fn inspect function <appname> <function-name>. To list the nodefn function's invoke endpoint we can type:

`fn inspect nodeapp hello`{{execute}}

Get the value from the annotation `fnproject.io/fn/invokeEndpoint` in the result of this inspect command. You can invoke the function using *curl* at this endpoint:
`export HELLO_FUNCTION_ENDPOINT=http://localhost:8080/invoke/<append the id from the endpoint>`{{execute}}

Now wit the variable set you should be able to invoke the function using curl:

`curl -X "POST" -H "Content-Type: application/json" -d '{"name":"Bob"}' $HELLO_FUNCTION_ENDPOINT`{{execute}}

