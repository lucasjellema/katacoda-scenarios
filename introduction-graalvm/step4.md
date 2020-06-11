# Creating Functions in other Languages 

The hello function we have been working with in the previous steps was implemented using Node JS (server side JavaScript). Fn supports many other runtime, such as Go, Python, Java and Ruby. Additionally, you can create a function from just any Docker Container, regardless which (combination of) runtime engines and languages you have used in it.

In this step you will create a function in Java. Feel free to try out the other runtimes as well.

Return to the home directory and create a new function called *hello-java* with Java as its runtime engine.
```
cd ~

fn init --runtime java hello-java
```{{execute}}

Check out the generated directory structure and Java Classes:

`ls -R`{{execute}}

Now inspect the generated Java class that handles requests - and can be customized by us. 
```
cd hello-java/src/main/java/com/example/fn

cat HelloFunction.java
```{{execute}}

Java Class HelloFunction.java was generated as the starting point for this function. You can check out file in the editor. 

Warning: if you make changes to the output of the file, ensure that you change the unit test accordingly because when the test fails, the function cannot be built and deployed. The unit test is in the source file hello-java/src/test/java/com/example/fn/HelloFunctionTest.java.

It is not as obvious as in the func.js generated for the Node runtime that an Fn handler is at play. However, also in the case of Java based functions, requests are handled by a generic Fn Java runtime handler before being passed to our own code. Check in *func.yaml* how the Java Class and method that the generic handler should forward the request to are specified. 

Deploy the Java Function hello-java locally, into the app that was created in step 2 of this scenario. You will again see a Docker Container Image being built. Or actually: two images. The first image is the build environment with the full Java JDK, Maven and facilities to run unit tests. The outcome of this first image is a Fat Jar that contains the built application artifact. This is the input for the second container image - that is based on the Java Runtime Environment, a much lighter weight image. The final result of deploying the function is the image based on JRE and with only the Fat Jar created for the function. 

```
cd ~/hello-java

fn -v deploy --app hello-app --local 
```{{execute}}

To invoke the Java function, execute this command:

`time fn invoke hello-app hello-java`{{execute}}

Note: we have added the `time` instruction to get timing for the cold startup time of the function. In step 6, we will use GraalVM powered ahead of time compiled Java applications, that are supposed to have a much faster cold startup time. Please remember the values you are getting for the timing of this command for comparison in step 6.

To send input to the function, use the following command:

`echo -n 'Your Own Name' | fn invoke hello-app hello-java --content-type application/json`{{execute}}

Again, a friendly, this time personalized, welcome message should be your reward.

## Further Explorations
To try out other languages, simply replace *java* as runtime with *go* or *python* in the call to `fn init`. For example:
```
cd ~

fn init --runtime go hello-go
```{{execute}}

### Custom Docker Containers as Function implementation
It is possible to take any Docker Container and use it as the implementation of a function. In that case the runtime is *docker*. The next step in this scenario demonstrates this compelling feature of Fn.

### GraalVM

 Project Fn also supports binary executables with GraalVM; there is a special runtime available that takes a Java application and builds it all the way into a container image with just a binary executable. This results in an even smaller image and even faster function warmup and execution. In step 5 of this scenario, you can check out this approach to packaging Java applications.