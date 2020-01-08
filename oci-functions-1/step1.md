Fn has been installed. Fn Server is running (locally). 


## Task

`fn start `{{execute T2}}

Check if Fn Server is running by checking the currently running Docker containers

`docker ps`{{execute}} 

Check the installed version - client and server - of Fn

`fn version`{{execute}} 

List the currently available Fn contexts

`fn list contexts`{{execute}}

# set context for local 

`fn use context default`{{execute}}

update the registry setting for the default content to something meaningless (do not ask why)

`fn update context registry fndemouser`{{execute}}


## Resources


Tutorial Getting Started with Fn environment
https://github.com/fnproject/tutorials/blob/master/install/README.md


Tutorial FN with Node
https://github.com/fnproject/tutorials/blob/master/node/intro/README.md


Docs on Fn on OCI
https://docs.cloud.oracle.com/iaas/Content/Functions/Tasks/functionscreatefncontext.htm
