# Real work

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

