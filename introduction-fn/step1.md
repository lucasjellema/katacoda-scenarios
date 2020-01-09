In this step, we will together prepare the environment for working with Fn. The Katacoda scenario environment runs Ubuntu and contains Docker. We need to add Fn CLI and Fn Server. 

## Wait for the Fn Server to be running

In the background we are currently preparing your Fn environment. Several Docker images are pulled and the Fn server is started. This takes up to three minutes. You can check if Fn Server is running by checking the currently running Docker containers using the following command:

`docker ps`{{execute}} 

Do not continue until you see a Docker container running based on image *fnproject/fnserver:latest*
![Fn Server is running](/lucasjellema/scenarios/introduction-fn/assets/fn-server-is-running.jpg)

## Get going with Fn

Check the installed version - client and server - of Fn

`fn version`{{execute}} 

List the currently available Fn contexts

`fn list contexts`{{execute}}

Notice we have a default context which deploys to a local Fn server. The default context is created the first time you run the Fn CLI. However, we need to select default as our current context and set a registry value for remote or local Docker use.

Set context to *default* - this is a local context that uses the locally running Fn server for deploying functions. 

`fn use context default`{{execute}}

Before we start using Fn, we need to configure Fn to point to an appropriate Docker registry so it knows where to push your function images to. Normally Fn points to your Docker Hub account by specifying your Docker Hub username. However, for pure local development we can simply configure Fn with an arbitrary value

So now update the registry setting for the default content to something meaningless.

`fn update context registry something-meaningless`{{execute}}

You can list the currently available Fn contexts again and see whether your changes had an effect (of course they did)

`fn list contexts`{{execute}}
