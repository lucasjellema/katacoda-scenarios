# Polyglot Interoperability: Java Calling Node

Here the HelloWorld example – the gentle introduction into Java code interacting with JavaScript. Your first taste of polyglot interoperability.
From folder /labs/java2js, 

`cd /labs/java2js`{{execute}}

Generate a .class with the javac command and then check the code outputs as expected:
```
javac nl/amis/java2js/HelloWorld.java

java nl/amis/java2js/HelloWorld
```{{execute}}

It may feel as if you have executed just some Java code. However, the Java Class engaged JavaScript to do some of the work. Nothing spectacular as such – but two languages as brothers in arms at run time. That in itself is quite something!
Inspect the contents of the Java Class definition:
`cat nl/amis/java2js/HelloWorld.java`{{execute}}


The polyglot context object is the bridge between Java and JavaScript. Not only can we execute JavaScript snippets and get simple values returned, the JavaScript code can also return a function – that we can execute later on – and many times – from Java.



## Advanced AOT - Getting Ahead of Ourselves

The following statement is used to create a natively executable image of the HelloWorld class *with embedded JavaScript* (Java interoperating with JavaScript, turned into a native executable). However, the Katacoda environment does not offer the required runtime resourcs to carry out this operation. The closed world analysis of all dependencies and the production of the executable need time and more memory than available.

```
cd /labs/java2js
$GRAALVM_HOME/bin/native-image -cp /labs/js2java/application-bundle.jar --language:js --verbose -H:Name=hello -H:Class=nl.amis.java2js.HelloWorld
```
The result should be a natively executable file of moderate size (compared to the Java Runtime environment you would need to run the HelloWorld class with JIT compilation). An example of this executable is available in the workshop resources, in folder */labs/native*.

Run this executable with the following command. No Java, no classpath. Only this one file (that contains a JavaScript runtime engine as well as the as yet unparsed, unprocessed JavaScript snippets):

`/labs/native/hello`{{execute}}

![](assets/run-native-image.png)
This tells you that the run time image - a combination of Java & JavaScript runtime engines along with the application - is close to 100MB. Without the JavaScript runtime, it would have been closer to 20MB. The startup time is phenomenal: less than 10 ms.