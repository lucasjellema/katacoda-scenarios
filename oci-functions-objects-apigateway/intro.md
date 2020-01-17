In this scenario you will create a Node JS application that creates files on OCI Object Storage. Then you will turn this application into a Function and deploy that function to Oracle Cloud Infrastructure. Next, you will expose this File Writer Function through API Gateway for public access. Finally, you will create, deploy and invoke a second function - RSSFeed Reader - that writes RSS Feed contents through FileWriter to OCI Object Storage.

You will use the OCI Console to verify the update of your API Deployment and to monitor the calls to API Gateway and check the creation of files on OCI Object Storage.

The scenario uses an Ubuntu 18.04 environment with Docker, OCI CLI and Fn CLI. Before you can start the steps in the scenario, the two Command Line interfaces are downloaded and installed. This will take about one minute. You will need Postman as well, if you want to invoke the API Gateway directly from your computer.

The scenario expects a number of preparations:
* you already have deployed a function called *hello* in an application called lab# where # is a number assigned to you (in OCI compartment lab-compartment)
* an API Gateway already has been provided in compartment lab-compartment with permissions to access functions in this compartment; the API Gateway is associated with a public subnet 
* there is already an API Deployment on the API Gateway - called MY_API_DEPL#

The scenario was prepared for the Meetup Workshop Cloud Native application development on Oracle Cloud Infrastructure on January 20th, hosted by AMIS|Conclusion in Nieuwegein in collaboration with REAL (the Red Expert Alliance) and Link from Portugal.

![Function on OCI to read RSS Feed and pass it to second Function (via API Gateway) to write to Object Storage](/lucasjellema/scenarios/oci-functions-objects-apigateway/assets/oci-rssfeeder.jpg)
