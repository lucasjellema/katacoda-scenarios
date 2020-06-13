# JIT with GraalVM - the Polyglot Runtime Engine for Java, Node, Python, R and more

GraalVM is known for some very advanced features - such as Ahead of Time Compilation and Polyglot interoperability. Additionally, GraalVM is a runtime engine - for Java and other JVM based languages (replacing HotSpot JIT compiler) and for many other languages (that are compiled to run on GraalVM through the Truffle framework).

In this step, let's see how you interact with this runtime platform. Note: it will not feel as anything special. You will use the regular commands belonging to the specific language (platform) - and they will be executed by GraalVM - and you will hardly even know it. That of course is one of the objective: transparent replacement of language runtime - with added value such as management and development tools, interoperability and better runtime characteristics, such as startup time, resource usage, throughput, runtime optimizations and performance. Some of the GraalVM language implementations have shown substatial benefits in this runtime department. However, for some use cases, the results are not as good. You will have to verify for yourself how well GraalVM runs your application. 

```
cd /labs/java
javac PrimeNumbers.java

java PrimeNumbers
```{{execute}}
