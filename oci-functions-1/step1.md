Fn has been installed.
## Task


2nd terminal:

fn start


1st terminal

Check if Fn Server is running 
`docker ps`{{execute}} 

Check the installed version - client and server - of Fn
`fn version`{{execute}} 
List the currently available Fn contexts
`fn list contexts`{{execute}}

# set context for local 
`fn use context default

fn update context registry fndemouser`{{execute}}

`fn init --runtime node hello`{{execute}}

`cd hello`{{execute}}

Create an Fn application - a container for multiple related functions:  
`fn create app nodeapp`{{execute}}
Deploy the Function Hello locally, into the app that was just created
`fn -v deploy -–app nodeapp --local `{{execute}}

Verify that a Docker Container Image has been built for Fn Function Hello:
`docker images | grep fndemouser `{{execute}}


`fn invoke nodeapp hello`{{execute}}

`echo -n '{"name":"Your Own Name"}' | fn invoke nodeapp nodefn --content-type application/json`{{execute}}

##Resources


Tutorial Getting Started with Fn environment
https://github.com/fnproject/tutorials/blob/master/install/README.md


Tutorial FN with Node
https://github.com/fnproject/tutorials/blob/master/node/intro/README.md


Docs on Fn on OCI
https://docs.cloud.oracle.com/iaas/Content/Functions/Tasks/functionscreatefncontext.htm
