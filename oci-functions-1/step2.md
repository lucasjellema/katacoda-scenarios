# Creating a Function with Fn and Deploying it to OCI

In this step we will create a simple function with Fn. We pick Node (JS) as our runtime - Go, Python, Java and Ruby are other out of the box options.

`fn init --runtime node hello`{{execute}}

`cd hello`{{execute}}

Three files have been created in the new directory *hello*.

`ls`{{execute}}

You could open func.js in the text editor to see the generated functionality.

Deploy the Function Hello, into an app that was created beforehand

`fn -v deploy --app lab-app `{{execute}}

Verify that a Docker Container Image has been built for Fn Function Hello:

`docker images | grep hello`{{execute}}

Time to invoke the function. The command for invoking the function is simply: `fn invoke <app-name> <function-name>`:

`fn invoke lab-app hello`{{execute}}



To send in a JSON object as input to the function, use the following command:

`echo -n '{"name":"Your Own Name"}' | fn invoke lab-app hello --content-type application/json`{{execute}}

Again, a friendly, this time personalized welcome message should be your reward - coming from the cloud.
