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

Do not continue until you see the file `/root/allSetInBackground` appear. If it appears, then the OCI CLI has been installed and you can continue.

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

Prepare a number of environment variables. Note: the assumptions here are a compartment called *lab-compartment*  and an API Gateway *lab-apigw* in that same compartment as well as an API Deployment called MY_API_DEPL# on the API Gateway. We need to get references to these resources in order to create new resources in the right place.  

```
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')

apigws=$(oci api-gateway gateway list -c $compartmentId)
export apiGatewayId=$(echo $apigws | jq -r --arg display_name "lab-apigw" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')
depls=$(oci api-gateway deployment list -c $compartmentId)
deploymentEndpoint=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .endpoint')
apiDeploymentId=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')
nss=$(oci os ns get)
export ns=$(echo $nss | jq -r '.data')

echo "Compartment OCID: $compartmentId"
echo "Namespace: $ns"
echo "API Deployment Id and Endpoint: $deploymentEndpoint and $apiDeploymentId"
```{{execute}}

## Fn Environment Preparation
Now Check the installed version of Fn CLI. Note: we do not need the Fn server at this stage.  

`fn version`{{execute}} 

To prepare the proper Fn context - associated with the OCI tenancy for this workshop, execute the next set of commands:

```
fn create context lab-fn-context --provider oracle

fn use context lab-fn-context

fn update context oracle.compartment-id $compartmentId

fn update context api-url https://functions.us-ashburn-1.oci.oraclecloud.com

fn update context registry iad.ocir.io/$ns/cloudlab-repo

fn update context oracle.profile FN
```{{execute}}

A remote Fn context based on Oracle as provider should now be set up. List the currently available and set Fn contexts to verify this.

`fn list contexts`{{execute}}

Next and finally, login to the private Docker Registry that is prepared for you on OCI.

`docker login iad.ocir.io`{{execute}}

The username you have to provide is composed of `<tenancy-namespace>/<username>`. The password is an Authentication Token generated for the specified user. Both these values are provided by your workshop instructor.

And now we are ready.