This scenario introduces the OCI Application Gateway. It is used to provide access to a Stock Response and to HTTP Backends. The  it is also used to expose serverless Functions on Oracle Cloud Infrastructure through a public endpoint. The scenario was prepared for the Meetup Workshop Cloud Native application development on Oracle Cloud Infrastructure on January 20th, hosted by AMIS|Conclusion in Nieuwegein in collaboration with REAL (the Red Expert Alliance) and Link from Portugal.

You will use the OCI Console to verify the creation of API Deployment with Routes and to monitor the calls to API Gateway. You can inspect the logging from the API Deployment on Object Storage - although it will take some time for the logging to arrive in the OCI Object Storage Bucket. 

The scenario uses an Ubuntu 18.04 environment with Docker and OCI CLI. Before you can start the steps in the scenario, the OCI Command Line interface is downloaded and installed. This will take about one minute. You will need Postman as well, if you want to invoke the routes on API Gateway directly from your computer.

The scenario expects a number of preparations:
* you already have deployed a function called *hello* in an application called lab# where # is a number assigned to you (in OCI compartment lab-compartment)
* an API Gateway already has been provided in compartment *lab-compartment* with permissions to access functions in this compartment; the API Gateway is associated with a public subnet 

You will need several pieces of information from the workshop instructor:
* your lab participant number  
* contents for OCI Config File
* private key to go with the OCI Config File
* username and password to login to OCI Console

Make sure you get those.


![Overview of Function running on Fn](/lucasjellema/scenarios/api-gateway-on-oci/assets/api-gateway-on-oci.jpg)


