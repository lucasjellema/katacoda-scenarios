Execute the following command to install the OCI CLI:
```
curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh > install-oci-cli.sh
chmod +777 install-oci-cli.sh
sudo ./install-oci-cli.sh --accept-all-defaults

# add this line to ~/.profile - to make oci a recognized shell command
echo 'oci() { /root/bin/oci "$@"; }' >> ~/.profile
# reload ~/.profile
. /root/.profile

```{{execute}}

You need to provide details on the OCI tenancy you will work in and the OCI user you will work as. Please open the IDE tab and edit these two files:

* ~/.oci/config
* ~/.oci/oci_api_key.pem

Paste the contents that you prepared in the [OCI Tenancy preparation scenario](https://katacoda.com/redexpertalliance/courses/oci-course/oci-lab-preparation-cloud-trial). 





### Finalizing the Environment 

Set the environment variable LAB_ID to the number provided to you by the workshop instructor.

`export LAB_ID=1`{{execute}}

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If you get a proper response, the OCI is configured correctly and you can proceed. If you run into an error, ask for help from your instructor.

Prepare a number of environment variables. Note: the assumptions here are a compartment called *lab-compartment*  and an API Gateway *lab-apigw* in that same compartment as well as an API Deployment called MY_API_DEPL# on the API Gateway. We need to get references to these resources in order to create new resources in the right place.  

```
export REGION=$(oci iam region-subscription list | jq -r '.data[0]."region-name"')
export REGION_KEY=$(oci iam region-subscription list | jq -r '.data[0]."region-key"')
export USER_OCID=$(oci iam user list --all | jq -r  '.data |sort_by(."time-created")| .[0]."id"')
export TENANCY_OCID=$(oci iam user list --all | jq -r  '.data[0]."compartment-id"') 
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

fn update context api-url https://functions.$REGION.oci.oraclecloud.com

fn update context registry ${REGION_KEY,,}.ocir.io/$ns/cloudlab-repo

fn update context oracle.profile FN
```{{execute}}

A remote Fn context based on Oracle as provider should now be set up. List the currently available and set Fn contexts to verify this.

`fn list contexts`{{execute}}

Next and finally, login to the private Docker Registry that is prepared for you on OCI.

The username you have to provide is composed of `<tenancy-namespace>/<username>`. 
```
NAMESPACE=$(oci os ns get| jq -r  '.data')
USER_USERNAME=$(oci iam user list --all | jq -r  '.data |sort_by(."time-created")| .[0]."name"')
echo "Username for logging in into Container Registry is $NAMESPACE/$USER_USERNAME"
```{{execute}}

The password is an Authentication Token generated for the specified user, in the OCI Tenancy preparation scenario. If you do not remember the authentication token, you can generate another one in the OCI Console:  https://console.REGION.oraclecloud.com/identity/users/<user-ocid>/swift-credentials or using the instructions in the preparation scenario. 

`echo "Open the console at https://console.${REGION,,}.oraclecloud.com/identity/users/$USER_OCID/swift-credentials"`{{execute}}

Now you can perform the login. Type the username and press enter, then type or paste the authentication token and press enter again. 

`docker login ${REGION_KEY,,}.ocir.io`{{execute}}

And now we are ready.

Prepare the following snipper for later usage:

Copy the JSON snippet produced by the next command between the curly braces in fil *oci-configuration.js*:
```
json="\"namespaceName\": \"$ns\",\n
\"region\": \"$REGION\",\n
\"compartmentId\": \"$compartmentId\",\n 
\"authUserId\": \"$USER_OCID\",\n
\"identityDomain\": \"identity.$REGION.oraclecloud.com\",\n
\"tenancyId\": \"$TENANCY_OCID\",\n
\"keyFingerprint\": \"YOUR_FINGERPRINT_FROM FILE ./oci_api_key.pem\",\n
\"privateKeyPath\": \"./oci_api_key.pem\",\n
\"coreServicesDomain\": \"iaas.$REGION.oraclecloud.com\",\n
\"bucketOCID\": \"$bucketOCID\",\n
\"bucketName\":\"$bucketName\",\n
\"objectStorageAPIEndpoint\":\"objectstorage.$REGION.oraclecloud.com\",\n
\"streamingAPIEndpoint\": \"streaming.$REGION.oci.oraclecloud.com\"\n
"
echo -e $json
```{{execute}}

Define the correct value for the *keyFingerprint* property in this file: replace the text *YOUR_FINGERPRINT_FROM FILE ./oci_api_key.pem* with the actual fingerprint value from the indicated file.