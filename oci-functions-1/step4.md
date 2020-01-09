# Creating Functions in other Languages 

The hello function we have been working with in the previous steps was implemented using Node JS (server side JavaScript). Fn supports many other runtime, such as Go, Python, Java and Ruby. Additionally, you can create a function from just any Docker Container, regardless which (combination of) runtime engines and languages you hae used in it.

In this step you will create a function in Java. Feel free to try out the other runtimes as well.

Return to 
```
cd ~

fn init --runtime java hello-java
```{{execute}}

Check out the generated directory structure and Java Classes:
```
ls -R

cd hello-java/src/main/java/com/example/fn

cat HelloFunction.java
```{{execute}}

Java Class HelloFunction.java was generated as the starting point for this function. You can check out file in the editor. 

Warning: if you make changes to the output of the file, ensure that you change the unit test accordingly because when the test fails, the function cannot be built and deployed. The unit test is in the source file hello-java/src/test/java/com/example/fn/HelloFunctionTest.java.

Deploy the Java Function hello-java locally, into the app that created in step 2.

`fn -v deploy --app nodeapp --local `{{execute}}

To invoke the Java function, execute this command:

`fn invoke nodeapp hello-java`{{execute}}

To send in a JSON object as input to the function, use the following command:

`echo -n 'Your Own Name' | fn invoke nodeapp hello-java --content-type application/json`{{execute}}

Again, a friendly, this time personalized, welcome message should be your reward.

## Further Explorations
To try out other languages, simply replace *java* as runtime with *go* or *python*.
