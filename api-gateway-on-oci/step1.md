## Wait for OCI CLI and Fn CLI to be installed

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

Paste the contents provided by the workshop instructor into these two files.

Set the environment variable LAB_ID to the number provided to you by the workshop instructor.

`export LAB_ID=1`{{execute}}

Do not continue until you see the file `/root/readyWithBackground` appear. If it appears, then the OCI CLI has been installed and you can continue.

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

## Environment Preparation
Prepare a couple of environment variable. Note: the compartment used here is the lab-compartment, the API Gateway is lab-apigw in that same compartment.
```
compartmentId=ocid1.compartment.oc1..aaaaaaaag4mbmj22ecmbbf43fjgzo4sd5vtldwbdq7z67p34p7xipkwfhzta
apiGatewayId=ocid1.apigateway.oc1.iad.amaaaaaa6sde7caaqh7lrxdlijuxxju66zpeycuy2qi72sggv6lgp7yvky4a
```{{execute}}

And now we are finally ready to create an API Deployment on API Gateway on Oracle Cloud Infrastructure.