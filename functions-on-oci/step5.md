# Configuring Functions with Configuration Values

Functions frequently need to be configured. Environment specific values such as endpoints, connection-details and file locations need to be set on the function. We typically use environment variables for passing such configuration settings. With Functions on OCI, that works more or less the same. You can set configuration variables using the Fn CLI or the func.yaml file. You can set configuration variables on the application or function level; the latter overrides the prior.

For details, check the documentation on [configuring functions](https://github.com/fnproject/docs/blob/master/fn/develop/configs.md).

After you deploy your function for the very first time, you can set function level configuration variables. The variables only apply to the specific function identified. Note that configuration values set for a function survive function redeployment. 

`fn config function <app-name> <fn-name> <key> <value>`.

Let's now make function hello return a message that we can configure through a configuration value.

Open *func.js* in the editor. Add the following line as line 4 - the first line within the anonymous function:  

`const greeting = process.env.GREETING ;`

This line reads the environment variable GREETING into variable *greeting*.

Then change the line that returns the final result from the function into:

`return {'message': (greeting?greeting:'Still Hello') +' '+ name}`

The greeting that is returned will now use the greeting set in the environment variable - if it was set. If not, we will still use Hello. Or actually use Still Hello.

Deploy the now changed function:

`fn -v deploy --app "lab$LAB_ID"`{{execute}}

And invoke the changed function. We expect to see *Still Hello* in the greeting.

`fn invoke "lab$LAB_ID" "hello$LAB_ID"`{{execute}}

Now let's go crazy and set a configuration value for the function.

`fn config function "lab$LAB_ID" "hello$LAB_ID" GREETING Hi`{{execute}}

This configures the key-value pair GREETING=Hi for the function. The environment variable GREETING is now available to the function. Let's invoke the function another time:

`fn invoke "lab$LAB_ID" "hello$LAB_ID"`{{execute}}

The configured greeting should be returned.

Try another configuration value for the function.

`fn config function "lab$LAB_ID" "hello$LAB_ID" GREETING "Bonjour mon ami"`{{execute}}

And invoke the function again:

`fn invoke "lab$LAB_ID" "hello$LAB_ID"`{{execute}}

The new value of the GREETING configuration setting should be returned.

Function Configuration values can also be set through the OCI CLI (see [docs](https://docs.cloud.oracle.com/iaas/tools/oci-cli/2.8.0/oci_cli_docs/cmdref/fn/function/update.html#cmdoption-config)) and through the OCI Console for Functions.

The next command will update the entire set of configuration values for function hello; there is no way through the OCI CLI to update just a single configuration value. 

`oci fn function update --function-id $funId --config '{"GREETING": "Goedendag"}'`{{execute}}

The response from this command show the full current state for the function, including the current values of the configuration parameters. Inspecting a function provides the same overview:

`fn inspect f lab$LAB_ID "hello$LAB_ID"`{{execute}}

Now that you know how to configure a function, we can manipulate the behavior of functions in an environment specific manner. No more hard coding, no more redeploying for changes that should just be configurable. 

