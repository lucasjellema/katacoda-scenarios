# Bonus: Ahead of Time Function Compilation with GraalVM

Note: this step is based very heavily on this article on Medium [Serverless Functions — Some Like It AOT!](https://medium.com/fnproject/serverless-functions-some-like-it-aot-ea8b46951335)

This tutorial walks through how to perform Ahead of Time compilation on an Fn function implemented with Java- to produce a function container image that is very small and has very rapid startup time.

## GraalVM

GraalVM is an open source high-performance embeddable polyglot virtual machine that recently sparked a lot of interests in the Java community as it supports Java and other JVM languages such as Groovy, Kotlin, Scala, etc. In addition, GraalVM also supports JavaScript (including the ability to run Node.js applications), Ruby, R, Python and even native languages that have an LLVM backend such as C or C++. GraalVM is incredibly powerful and versatile, it can help in many ways from boosting the performance of Java applications to enabling polyglot applications development that combine different languages in order to to get the best tools and features from different ecosystems. For example, using GraalVM, it is possible to use R for data visualization, Python for machine learning and JavaScript to combine those two functionalities together.

This step will focus on a specific GraalVM capability, i.e. GraalVM Ahead-of-time Compilation (AOT) and more specifically on GraalVM native-image feature with Java functions.

## Create a Native Java Function 

Return to the home directory. Bootstrap a GraalVM based Java function called *hello-java-aot* with Java Native (aka GraalVM Ahead of Time compilation) as its runtime engine.

```
cd ~

fn init --init-image fnproject/fn-java-native-init hello_java_aot
```{{execute}}

If you compare this to the approach used for generating a "regular" Java function, the key difference is that we instruct the Fn CLI to rely the fnproject/fn-java-native-init Docker init-image (see here for more details on init-image) to generate a boilerplate GraalVM based Java function (instead of relying on the regular java runtime option).

Check out the generated directory structure and Java Classes:

`ls -R`{{execute}}

The func.yaml contains some meta-data related to the function (its version, its name, etc.). It is very similar to a regular Java func.yaml, the only difference being the runtime entry. The Java function uses the java runtime while the GraalVM native-image function rely on the default Docker runtime which also explains the presence of a Dockerfile.

Now inspect the generated files and notice the Docker file. 
```
cd hello_java_aot
ls -R
cat Dockerfile
```{{execute}}

To generate the Docker image of the function, the Fn CLI is relying on the Dockerfile that was generated during the previous init phase. If you inspect this Dockerfile or if you look at the verbose output of the depoyment, you will notice that one of the step is using GraalVM's native-image utility to compile the Java function ahead-of-time into a native executable.

The resulting function does not run on a "regular" Java virtual machine but uses the necessary components like memory management, thread scheduling from a different virtual machine called Substrate VM (SVM). SVM, which is a part of the GraalVM project, is written in Java and is embedded into the generated native executable of the function. Given it is a small native executable, this native function has a faster startup time and a lower runtime memory overhead compared to the same function compiled to Java bytecode running on top of a "regular" JVM.

That native function executable is finally added to a base lightweight image (busybox:glibc) with some related dependencies. This will constitute the function Docker image that the Fn infrastructure will use when the function is invoked.

## Deploy and Run the Java Application

Java Class HelloFunction.java was generated as the starting point for this function. You can check out file in the editor. 

Warning: if you make changes to the output of the file, ensure that you change the unit test accordingly because when the test fails, the function cannot be built and deployed. The unit test is in the source file hello-java-aot/src/test/java/com/example/fn/HelloFunctionTest.java.

Note: the fact that is application is deployed as native Java application does not mean anything for the way you program the Java code. (well, in all honesty, it does; there are some Java mechanism that are not available in native Java applications - such as dynamic class loading and certain elements of reflection; that is why turning Spring applications into Native Java applications is not a simple challenge).

Deploy the native Java application just as before the regular Java application

```
fn -v deploy --app hello-app --local 
```{{execute}}
Note: the process of turning the Java application into a natively executable image can take quite long. We perform some heavy lifting once (at compile time) to benefit many times (on every execution) later on.  

One major difference we expect to see is in the size of the Docker image prepared for our function. It should be small - much smaller than the container image produced for the regular Java function that contains a full blown Java Runtime environment.

To check and compare the sizes of the Docker images, execute this command: 
`docker images | grep hello `{{execute}}

![](assets/docker-function-images.png)

As you can see, the function image that includes everything required to run, including the operating system and the function native executable, is only weighing around 21 MB! Since all necessary components of a virtual machine (ex. GC) are embedded into the function executable, there is no need to have a separate Java runtime (JRE) in the function Docker image. When a function is invoked through Fn, Fn will instruct Docker to pull and launch the corresponding container image and hence the smaller this container image is, the better it is to reduce the cold-startup time of this function.

To give us an idea, we can quickly measure the cold startup of the function. Execute this command:

`time fn invoke hello-app hello_java_aot`{{execute}}

We expect to see that the cold startup time of a GraalVM native-image function is improved, comparing to the regular Java function with JIT compilation.

Those numbers will vary depending on the machine you run the tests on but this basic benchmark shows that the cold startup of the GraalVM native-image function is faster. In this particular example, the cold startup of the GraalVM native-image function is probably ~70% of the cold startup time of the same Java function that uses a regular JVM (HotSpot in the case of Fn with Java runtime).
![](assets/aot-vs-jit-startuptimes.png)





