# Bonus: Custom Docker Images as Function Implementation

Note: this step is based very heavily on this tutorial on the Fn Project Website [Make your own Linux command Function with HotWrap and a Customer Docker Image](https://fnproject.io/tutorials/docker/CustomLinuxContainer/)

This tutorial walks through how to use a custom Docker image to define an Fn function. Although Fn functions are packaged as Docker images, when developing functions using the Fn CLI developers are not directly exposed to the underlying Docker platform. Docker isn’t hidden (you can see Docker build output and image names and tags), but you aren’t required to be very Docker-savvy to develop functions with Fn.

What if you want to make a function using Linux command line tools, or a script that does not involve one of the supported Fn languages? Can you use your Docker image as a function? Fortunately the design and implementation of Fn enables you to do exactly that. Let’s build a simple custom function container image to see how it’s done.

The *Fn HotWrap* tool allows you to create functions using conventional Unix command line tools and a Docker container. The tool provides the FDK contract for any command that can be run on the command line. Once wrapped, event data is passed to your function via STDIN and the output is returned through STDOUT.

## Initial Linux Command

Try out this command - that simply reverses text.
`echo "Hello World" | rev`{{execute}}

Our function implementation is simple: we only need to call the command /bin/rev with the input to the function and produce the result of the rev* command as output.

## Initialize Function

We need a directory for our project.
```
cd ~
mkdir revfunc
```{{execute}}
and change into the directory:
`cd revfunc`{{execute}}

In the folder , create a func.yaml file 
`touch func.yaml`{{execute}}

Open this file in the text editor and copy/paste the following as its content:
<pre class="file" data-target="clipboard">
schema_version: 20180708
name: revfunc
version: 0.0.1
runtime: docker
triggers:
- name: revfunc
  type: http
  source: /revfunc
</pre>

This is a typical func.yaml except that instead of declaring the runtime as a programming language we've specified *docker*. If you were to type fn build right now you'd get the error:

`Fn: Dockerfile does not exist for 'docker' runtime`

This is because when you set the runtime type to *docker*. The `fn build` command defers to your Dockerfile to build the function container image–and you haven’t defined one yet!

## Create the Dockerfile for the Function
Create a file named Dockerfile 
`touch Dockerfile`{{execute}}
and copy/paste the following as its content:
<pre class="file" data-target="clipboard">
FROM alpine:latest

# Install hotwrap binary in your container
COPY --from=fnproject/hotwrap:latest  /hotwrap /hotwrap
CMD "/bin/rev"
ENTRYPOINT ["/hotwrap"]
</pre>

Here is an explanation of each of the Docker commands.

* FROM alpine:latest - Use the latest version of Alpine Linux as the base image.
* COPY --from=fnproject/hotwrap:latest /hotwrap /hotwrap - Install the HotWrap Fn tool.
* CMD "/bin/rev" - The Linux command to run.
* ENTRYPOINT ["/hotwrap"] - Tells the container to execute the previous command using HotWrap: /hotwrap /bin/rev

## Build and Deploy the Function
Once you have your custom Dockerfile you can simply use fn build to build your function. Give it a try:
`fn -v build`{{execute}}

Just like with a default build, the output is a container image. From this point forward everything is just as it would be for any Fn function. Since you’ve previously started an Fn server, you can deploy it.

`fn -v deploy --app hello-app --local --no-bump`{{execute}}
List the functions in the hello-app application, to see that now revfunc is a function:

`fn list functions hello-app`{{execute}}

Pro tip: The Fn cli let's you abbreviate most of the keywords so you can also say `fn ls f hello-app`! You should see the same output.

## Invoking the Function
With the function deployed let’s invoke it to make sure it’s working as expected.

`echo "Hello World" | fn invoke hello-app revfunc`{{excute}}

For this command you should see the following output: `dlroW olleH`

We included an HTTP trigger declaration in the func.yaml so we can also call the function with curl:
`curl --data "Hello World" -H "Content-Type: text/plain" -X POST http://localhost:8080/t/hello-app/revfunc`{{execute}}

What about this one?

`curl --data "Eva, can I see bees in a cave" -H "Content-Type: text/plain" -X POST http://localhost:8080/t/hello-app/revfunc`{{execute}}


## Conclusion

One of the most powerful features of Fn is the ability to use custom defined Docker container images as functions. This feature makes it possible to customize your function’s runtime environment including letting you use Linux command line tools as your function. And thanks to the Fn CLI's support for Dockerfiles it's the same user experience as when developing any function.

Having completed this step you've successfully built a function using a custom Dockerfile. Congratulations!
