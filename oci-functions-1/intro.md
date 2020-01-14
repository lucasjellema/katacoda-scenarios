This scenario introduces the OCI Application Gateway. It is used to provide access to a Stock Response and to HTTP Backends. The  it is also used to expose serverless Functions on Oracle Cloud Infrastructure through a public endpoint. 

You will use the OCI Console to verify the creation of API Deployment with Routes and to monitor the calls to API Gateway.

The scenario uses an Ubuntu 18.04 environment with Docker, OCI CLI and Fn CLI. Before you can start the steps in the scenario, the two Command Line interfaces are downloaded and installed. This will take about one minute. You will need Postman as well, if you want to invoke the API Gateway directly from your computer.

The scenario expects a number of preparation:
* you already have deployed a function called *hello* in an application called lab# where # is a number assigned to you (in OCI compartment lab-compartment)
* an API Gateway already has been provided in compartment lab-compartment with permissions to access functions in this compartment; the API Gateway is associated with a public subnet 
