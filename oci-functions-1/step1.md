The environment is currently being prepared. While that is happening, we can take a look at the Stream `lab-stream` in the `lab-compartment`. Note: there is a fairly strict limit on the number of Stream (partitions) that we are allowed to create (out of the box); therefore we are all sharing the stream in this workshop.

Open the OCI Console as lab-user at: https://console.us-ashburn-1.oraclecloud.com/storage/streaming . Here you should see the stream `lab-stream`. 

Click on the stream *lab-stream* to go to the details page. Click on Produce Test Message to... well, produce a test message of course.

Type a message and press Produce. The console will indicate that the message was produced successfully.

To check on the message, close the popup window and press Load Messages. All recently published messages on the stream are displayed – including the one that was just published.

This is the simplest example of pub/sub through OCI Streaming.


## Wait for OCI CLI (and Fn CLI) to be installed

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
Now Check the installed version of Fn CLI. Note: we do not need the Fn server at this stage.  

`fn version`{{execute}} 

Configure and set remote context 

List the currently available Fn contexts

`fn list contexts`{{execute}}

Create an appropriate Fn context for working with OCI as provider (see [OCI Docs on Functions](https://docs.cloud.oracle.com/iaas/Content/Functions/Tasks/functionscreatefncontext.htm)).

`fn create context lab-fn-context --provider oracle`{{execute}}

`fn use context lab-fn-context`{{execute}}

Update the context with the settings relevant for this workshop. Note: the compartment used here is the lab-compartment, the API Gateway is lab-apigw in that same compartment.
```
compartmentId=ocid1.compartment.oc1..aaaaaaaag4mbmj22ecmbbf43fjgzo4sd5vtldwbdq7z67p34p7xipkwfhzta
apiGatewayId=ocid1.apigateway.oc1.iad.amaaaaaa6sde7caaqh7lrxdlijuxxju66zpeycuy2qi72sggv6lgp7yvky4a

depls=$(oci api-gateway deployment list -c $compartmentId)
deploymentEndpoint=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .endpoint')
apiDeploymentId=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')

fn update context oracle.compartment-id $compartmentId

fn update context api-url https://functions.us-ashburn-1.oci.oraclecloud.com

fn update context registry iad.ocir.io/idtwlqf2hanz/cloudlab-repo

fn update context oracle.profile FN
```{{execute}}

You can list the currently available Fn contexts again and see whether your changes had an effect (of course they did)

`fn list contexts`{{execute}}

Next and finally, login to the private Docker Registry that is prepared for you on OCI.

`docker login iad.ocir.io`{{execute}}

The username you have to provide is composed of `<tenancy-namespace>/<username>`. The password is an Authentication Token generated for the specified user. Both these values are provided by your workshop instructor.

And now we are finally ready to create Functions on Oracle Cloud Infrastructure and expose them through OCI API Gateway.