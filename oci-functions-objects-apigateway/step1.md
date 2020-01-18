## Wait for OCI CLI and Fn CLI to be installed

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

## Environment Preparation
Now Check the installed version of Fn CLI. Note: we do not need the Fn server at this stage.  

`fn version`{{execute}} 

Configure and set remote context 

List the currently available Fn contexts

`fn list contexts`{{execute}}

Create an appropriate Fn context for working with OCI as provider (see [OCI Docs on Functions](https://docs.cloud.oracle.com/iaas/Content/Functions/Tasks/functionscreatefncontext.htm)).

`fn create context lab-fn-context --provider oracle`{{execute}}

`fn use context lab-fn-context`{{execute}}

Prepare a number of environment variables. Note: the assumptions here are a compartment called *lab-compartment*  and an API Gateway *lab-apigw* in that same compartment as well as an API Deployment called MY_API_DEPL# on the API Gateway. We need to get references to these resources in order to create new resources in the right place.  

```
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')

apigws=$(oci api-gateway gateway list -c $compartmentId)
export apiGatewayId=$(echo $apigws | jq -r --arg display_name "lab-apigw" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')
depls=$(oci api-gateway deployment list -c $compartmentId)
deploymentEndpoint=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .endpoint')
apiDeploymentId=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')
# get namespace
nss=$(oci os ns get)
export ns=$(echo $nss | jq -r '.data')

```{{execute}}

Update the context with the settings relevant for this workshop.
```
fn update context oracle.compartment-id $compartmentId

fn update context api-url https://functions.us-ashburn-1.oci.oraclecloud.com

fn update context registry iad.ocir.io/$ns/cloudlab-repo

fn update context oracle.profile FN
```{{execute}}

You can list the currently available Fn contexts again and see whether your changes had an effect (of course they did)

`fn list contexts`{{execute}}

Next and finally, login to the private Docker Registry that is prepared for you on OCI.

`docker login iad.ocir.io`{{execute}}

The username you have to provide is composed of `<tenancy-namespace>/<username>`. The password is an Authentication Token generated for the specified user. Both these values are provided by your workshop instructor.

And now we are finally ready to create Functions on Oracle Cloud Infrastructure and expose them through OCI API Gateway.