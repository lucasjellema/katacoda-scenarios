# Creating a Function with Fn 

In this step we will create a simple function with Fn. We pick Node (JS) as our runtime - Go, Python, Java and Ruby are other out of the box options.

`fn init --runtime node hello`{{execute}}

`cd hello`{{execute}}

Three files have been created in the new directory *hello*.

`ls`{{execute}}

The fn init command generated a func.yaml function configuration file; this file provides instructions to the Fn Server to build, deploy and invoke the function. Let's look at the contents:

`cat func.yaml`{{execute}}

The generated func.yaml file contains metadata about your function and declares a number of properties including:

* schema_version--identifies the version of the schema for this function file. Essentially, it determines which fields are present in func.yaml.
* name--the name of the function. Matches the directory name.
* version--automatically starting at 0.0.1.
* runtime--the name of the runtime/language which was set based on the value set in --runtime.
* entrypoint--the name of the Docker execution command to invoke when your function is called, in this case node func.js.

There are other user specifiable properties that can be defined in the yaml file for a function. We do not need those for this simple example.

The package.json file is present in (most) Node applications: it specifies all the NPM dependencies for your Node function - on third party libraries and also on the Fn FDK for Node (@fnproject/fdk).

`cat package.json`{{execute}}

You could open func.js in the text editor to see the generated functionality of the function: that is where the real action takes place when the function is invoked.

## Deploy and Invoke the Function

Create an Fn application - a container for multiple related functions:  

`fn create app hello-app`{{execute}}

Deploy the Function Hello locally, into the app that was just created

`fn -v deploy --app hello-app --local `{{execute}}

When you deploy a function like this, Fn is dynamically generating a Dockerfile for your function, building a container, and then loading that container for execution when the function is invoked. 

Note: Fn is actually using two images. The first contains the necessary build tools and produces the runtime artefact. The second image packages all dependencies and any necessary language runtime components. Using this strategy, the final function image size can be kept as small as possible.

When using fn deploy --local, fn server builds and packages your function into a container image which resides on your local machine. You can now verify that a Docker Container Image has been built for Fn Function Hello:

`docker images | grep hello`{{execute}}

Using the following command, you can check the Fn applications (or function clusters) in your current context:
`fn list apps`{{execute}}

With the next command, you can check which functions have been deployed into a specific application:

`fn list functions hello-app`{{execute}}

Time now to invoke the function. The command for invoking the function is simply: `fn invoke <app-name> <function-name>`:

`fn invoke hello-app hello`{{execute}}

To send in a JSON object as input to the function, use the following command:

`echo -n '{"name":"Your Own Name"}' | fn invoke hello-app hello --content-type application/json`{{execute}}

Again, a friendly, this time personalized, welcome message should be your reward.

What is happening here: when you invoke "hello-app hello" the Fn server looked up the "hello-app" application and then looked for the Docker container image bound to the "hello" function, started the container (if it was not already running) and send the request to the handler listening inside the container.

![Fn Server handles request](/lucasjellema/scenarios/introduction-fn/assets/fn-server-functions.jpg)
