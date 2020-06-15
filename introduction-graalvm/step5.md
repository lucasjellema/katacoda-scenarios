# Polyglot Interoperability: Java Calling JavaScript

GraalVM is not only a superior JIT compiler as well as an AOT compiler that produces natively executable images from Java applications. It is also a polyglot runtime platform for many programming languages and it offers polyglot interoperability. A program written in one language can execute snippets (or chunks) written in a different language, thus leveraging existing libraries and components and leveraging the strengths of each language. To add a certain *je ne sais quoi* to a program. And capture the *zeitgeist* with the hottest programming language in town.

In this section, you will see the first examples of Polyglot Interoperability - starting from Java and calling out to JavaScript.

## Execute Polyglot Java Class HelloWorld
Here the HelloWorld example – the gentle introduction into Java code interacting with JavaScript. Your first taste of polyglot interoperability.

From folder /labs/java2js, 

`cd /labs/java2js`{{execute}}

Generate a .class with the javac command and then check the code outputs as expected:
```
javac nl/amis/java2js/HelloWorld.java

java nl/amis/java2js/HelloWorld
```{{execute}}

It may feel as if you have executed just some Java code. However, the Java Class engaged JavaScript to do some of the work. Nothing spectacular as such – but two languages as brothers in arms at run time. That in itself is quite something!

## Inspecting the Interoperability in the Source Code

Inspect the contents of the Java Class definition:

`cat nl/amis/java2js/HelloWorld.java`{{execute}}

The polyglot context object is the bridge between Java and JavaScript. Not only can we execute JavaScript snippets and get simple values returned, the JavaScript code can also return a function – that we can execute later on – and many times – from Java.

The line
`polyglot.eval("js", "console.log('Hello JavaScript!')");`
simply executes a JS snippet that prints a string to the system output. Seems innocent enough. But of course it is quite significant. It is a Mama Mia! in a piece of English text. A JavaScript statement in the middle of a Java program. With hardly any ceremony.

And it gets better:
```
Value helloWorldFunction= polyglot.eval("js"
        		               , "(function(name) { return `Hello ${name}, welcome to the world of JavaScript` })");
// Use the function
String greeting = helloWorldFunction.execute("John Doe").asString();
System.out.println(greeting);
```
The `polyglot.eval` call evaluates the JavaScript snippet (again). This snippet evaluates to a function object. This object is not executed - it is returned. In Java, we now have at our disposal a function object (reference) in variable *helloWorldFunction*. We can invoke this function as many times as we like. simply by executing the *execute* method on the object, passing in the input parameters required by the function that we want to have executed. The call *helloWorldFunction.execute("John Doe")* execute the function that was defined in JavaScript. We, Java developers who simply have been given the function reference, are not bothered at all by the fact that JavaScript is lurking under the covers. It is transparent to us. 

The result of executing the function is simply returned as excepted from any Java method call.

### Catching Exceptions from The Other Side
The Java code that invokes the JavaScript can of course run into exceptions in the foreign language. With a fairly straightforward `try { } catch() {}` the code can catch these runtim PolyglotExceptions and inspect them and act upon them:

```
try {
	polyglot.eval("js", "console.log('Hello JavaScript!'); throw 'I do not feel like executing this';");
} catch (PolyglotException e) {
    System.out.println("Exception caught from JavaScript Execution. Orginal Exception: "+e.getMessage());
 } 
```        

## Load and Execute JavaScript from Resource File

JavaScript code does not need to be inline or embedded as Strings in the Java source. In fact, it is probably a much better idea to keep Java and JavaScript in separate files as much as possible.

Check class LoadAndRunJS. In this class you will find a simple example of how the JavaScript is not embedded in Java, but is loaded from a separate file – calculator.js - instead.

`cat nl/amis/java2js/LoadAndRunJS.java`
Using the ClassLoader to load a file resource, the JavaScript functions *Calculator* and *Fibonacci* are loaded. Subsequently, the loaded snippets of JS code are evaluated through the Polyglot context object, resulting in a bindings object (a Map) that has the functions as entries. The names of the JS functions are the keys of the objects in *binding*.  

```
cd /labs/java2js

javac nl/amis/java2js/LoadAndRunJS.java

java nl/amis/java2js/LoadAndRunJS
```{{execute}}
So this Java Class is producing Fibonacci and SQRT results - without doing any calculations itself. It leverages a library - written in JavaScript.

### Extending the Calculator's capabilities

Add a function to the file /labs/java2js/calculator.js:
```
echo -e "\n function doubleIt(num) { \n return 2*num \n}" >> /labs/java2js/calculator.js
cat  /labs/java2js/calculator.js
```{{execute}}
Check that the function doubleIt is now part of the library calculator.js.

Now execute the LoadAndRunJS class again - without having made any change or recompiled the class:

```
java nl/amis/java2js/LoadAndRunJS
```{{execute}}
The Java Class evaluates the JavaScript library calculator.js each time it is run. It now finds function *doubleIt* and executes it.

## Callback from JavaScript to Java
Check class CallbackFromJS2J. In this class, a call is made to JavaScript – after a Java object has been instantiated and put in the bindings map in the Polyglot context. The JavaScript code can retrieve this object and invoke methods on it.

`cat /labs/java2js/nl/amis/java2js/CallbackFromJS2J.java`{{execute}}

The *doIt* method instantiates an Object based on JavaClass *FriendlyNeighbour* and stores this class in the bindings object. This makes it available to the JavaScript code invoked by CallbackFromJS2J.

The definition of Class *FriendlyNeighbour* is shown here:
`cat  /labs/java2js/nl/amis/java2js/FriendlyNeighbour.java`{{execute}}

So we have:
*CallbackFromJS2J (Java) => JavaScript snippet => FriendlyNeighbour (Java)* 

To execute:
```
cd /labs/java2js

javac nl/amis/java2js/FriendlyNeighbour.java
javac nl/amis/java2js/CallbackFromJS2J.java

java nl/amis/java2js/CallbackFromJS2J
```{{execute}}
Here you see the result of Java executing JavaScript that leverages a Java object instantiated by the calling Java code. Note: the JS snippet does not know that object *friend* is a Java object. To the JS snippet, this is a generic, polyglot object that can have properties such as readable and settables variables and calleable functions. 

You could try additional things, such as adding variables or methods to the FriendlyNeighbour class and see if you can execute and access methods and data from both sides of the polyglot divide.


## Bonus: Advanced AOT - Native Image for Polyglot Java Applications

The following statement is used to create a natively executable image of the HelloWorld class *with embedded JavaScript* (Java interoperating with JavaScript, turned into a native executable). 

However, the Katacoda environment does not offer the required runtime resourcs to carry out this operation. The closed world analysis of all dependencies and the production of the executable need time and more memory than available.

```
cd /labs/java2js
$GRAALVM_HOME/bin/native-image -cp /labs/js2java/application-bundle.jar --language:js --verbose -H:Name=hello -H:Class=nl.amis.java2js.HelloWorld
```
Note: the application-bundle.jar file contains the resources used for creating the native image - specifically in this case the Java Class file HelloWorld. Check the contents of the jar file with this command

`jar tf /labs/js2java/application-bundle.jar`{{execute}}

The result should be a natively executable file of moderate size (compared to the Java Runtime environment you would need to run the HelloWorld class with JIT compilation). An example of this executable is available in the workshop resources, in folder */labs/native*.

Run this executable with the following command. No Java, no classpath. Only this one file (that contains a JavaScript runtime engine as well as the as yet unparsed, unprocessed JavaScript snippets):

`/labs/native/hello`{{execute}}

![](assets/run-native-image.png)
This tells you that the run time image - a combination of Java & JavaScript runtime engines along with the application - is close to 100MB. Without the JavaScript runtime, it would have been closer to 20MB. The startup time is phenomenal: less than 10 ms.