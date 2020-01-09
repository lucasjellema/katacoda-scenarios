## Wait for OCI CLI and Fn CLI to be installed

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

Paste the contents provided by the workshop instructor into these two files.

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

Do not continue until you see the file `/root/readyWithBackground` appear. If it appears, then the OCI CLI has been installed and you can continue.

## Fn Client and Context
Now Check the installed version of Fn CLI. Note: we do not need the Fn server at this stage.  

`fn version`{{execute}} 

Configure and set remote context 

`fn list contexts`{{execute}}

Notice we have a default context which deploys to a local Fn server. The default context is created the first time you run the Fn CLI. However, we need to select default as our current context and set a registry value for remote or local Docker use.

Set context to *default* - this is a local context that uses the locally running Fn server for deploying functions. 

`fn use context default`{{execute}}

Before we start using Fn, we need to configure Fn to point to an appropriate Docker registry so it knows where to push your function images to. Normally Fn points to your Docker Hub account by specifying your Docker Hub username. However, for pure local development we can simply configure Fn with an arbitrary value

So now update the registry setting for the default content to something meaningless.

`fn update context registry something-meaningless`{{execute}}

You can list the currently available Fn contexts again and see whether your changes had an effect (of course they did)

`fn list contexts`{{execute}}
