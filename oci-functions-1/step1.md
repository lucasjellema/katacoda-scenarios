Fn has been installed.
## Task


2nd terminal:

fn start


1st terminal


`export MY_VAR="mijn waarde"`{{execute}}

`echo  $STATUS`{{execute}}

`docker ps`{{execute}} 

export FN_API_URL=https://2886795346-8080-ollie02.environments.katacoda.com:8080

`fn version`{{execute}} 
`fn list contexts`{{execute}}

# set context for local 
`fn use context default
fn update context registry fndemouser`{{execute}}

`fn init -–runtime node hello`{{execute}}
`cd hello`{{execute}}

`fn create app nodeapp`{{execute}}
`fn -v deploy –app nodeapp --local`{{execute}}

`docker images | grep fndemouser`{{execute}}


`fn invoke nodeapp hello`{{execute}}

echo -n '{"name":"Your Own Name"}' | fn invoke nodeapp nodefn --content-type application/json

Resources:


Tutorial Getting Started with Fn environment
https://github.com/fnproject/tutorials/blob/master/install/README.md


Tutorial FN with Node
https://github.com/fnproject/tutorials/blob/master/node/intro/README.md


Docs on Fn on OCI
https://docs.cloud.oracle.com/iaas/Content/Functions/Tasks/functionscreatefncontext.htm
