Fn has been installed. Fn Server is running (locally). 


## Wait for the Fn Server to be running

In the background we are currently preparing your Fn environment. Several Docker images are pulled and the Fn server is started. This takes up to three minutes. You can check if Fn Server is running by checking the currently running Docker containers using the following command:

`docker ps`{{execute}} 

Do not continue until you see a Docker container running based on image *fnproject/fnserver:latest*

## Get going with Fn

Check the installed version - client and server - of Fn

`fn version`{{execute}} 

List the currently available Fn contexts

`fn list contexts`{{execute}}

Set context to *default* - this is a local context that uses the locally running Fn server for deploying functions. 

`fn use context default`{{execute}}

Update the registry setting for the default content to something meaningless ()

`fn update context registry something-meaningless`{{execute}}
