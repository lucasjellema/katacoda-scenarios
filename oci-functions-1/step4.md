# Creating Functions in other Languages 

The hello function we have been working with in the previous steps was implemented using Node JS (server side JavaScript). Fn supports many other runtime, such as Go, Python, Java and Ruby. Additionally, you can create a function from just any Docker Container, regardless which (combination of) runtime engines and languages you hae used in it.

In this step you will create a function in Java. Feel free to try out the other runtimes as well.

Return to 
```
cd ~

fn init --runtime node hello-java
```{{execute}}

Check out the generated directory structure and Java Classes:
```
ls -R

cd hello-java/src/main/java/com/example/fn

cat HelloFunction.java

cd ~\hello-java
```{{execute}}

Java Class HelloFunction.java was generated as the starting point for this function.

Deploy the Java Function hello-java locally, into the app that was just created

`fn -v deploy --app nodeapp --local `{{execute}}

To invoke the function. The command for invoking the function is simply: `fn invoke <app-name> <function-name>`:

`fn invoke nodeapp hello-java`{{execute}}

To send in a JSON object as input to the function, use the following command:

`echo -n '{"name":"Your Own Name"}' | fn invoke nodeapp hello-java --content-type application/json`{{execute}}

Again, a friendly, this time personalizedm welcome message should be your reward.

Replace *java* as runtime with *go* or *python* to try out other options as well.
