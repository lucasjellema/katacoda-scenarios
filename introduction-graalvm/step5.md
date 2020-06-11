# Bonus: Ahead of Time Function Compilation with GraalVM

This step will focus on a specific GraalVM capability, i.e. GraalVM Ahead-of-time Compilation (AOT) and more specifically on GraalVM native-image feature with Java functions.

## Ahead of Time Compilation - generating native image 

The GraalVM native image utility has been installed in the Virtual Machine. However, the AOT compilation requires a fair amount of memory. It may exhaust the physical resources in the Katacoda environment. 

A first quick attempt you could make to create a natively executable image of the HelloWorld class with embedded JavaScript:

```
cd /labs/js2java
$GRAALVM_HOME/bin/native-image -cp ./application-bundle.jar --language:js --verbose -H:Name=hello -H:Class=nl.amis.java2js.HelloWorld`{{execute}}

Even this extremely simple example takes more than five minutes to create the executable file. The closed world analysis of all dependencies and the production of the executable need time and memory.

The result should be a natively executable file of moderate size (compared to the Java Runtime environment you would need to run the HelloWorld class with JIT compilation)

Run this executable with the following command. No Java, no classpath. Only this one file (that contains a JavaScript runtime engine as well as the as yet unparsed, unprocessed JavaScript snippets):

`./hello`{{execute}}

![](assets/run-native-image.png)
This tells you that the run time image - a combination of Java & JavaScript runtime engines along with the application - is close to 100MB. Without the JavaScript runtime, it would have been closer to 20MB. The startup time is phenomenal: less than 10 ms.