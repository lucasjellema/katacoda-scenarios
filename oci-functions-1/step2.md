# Creating, Deploying and Invoking a Function on OCI

In this step we will create a simple function with Fn. We pick Node (JS) as our runtime - Go, Python, Java and Ruby are other out of the box options.

`fn init --runtime node hello`{{execute}}

`cd hello`{{execute}}

Three files have been created in the new directory *hello*.

`ls`{{execute}}

You could open func.js in the text editor to see the generated functionality. Feel free to edit the file - but please make sure it will execute correctly!

## Create Application

Set the environment variable LAB_ID to the number provided to you by the workshop instructor.

`export LAB_ID=1`{{execute}}

Note: Public Subnet-vcn-lab

`export SUBNET_OCID=ocid1.subnet.oc1.iad.aaaaaaaagfz4auw6rgkqbg4huwxno42cnuscafgvyivmdwl7lj6gabpktmvq`{{execute}}
TODO load SUBNET_OCID as OCID for subnet with name Subnet-vcn-lab

Now create the application that will be the container for your functions:

`fn create app "lab$LAB_ID" --annotation "oracle.com/oci/subnetIds=[\"$SUBNET_OCID\"]"`{{execute}}

See the list of applications - that should include your new application:

`fn list apps`{{execute}}

## Deploy the Function

Deploy the Function Hello, into an app that was created beforehand

`fn -v deploy --app "lab$LAB_ID"`{{execute}}

Verify that a Docker Container Image has been built for Fn Function Hello:

`docker images | grep hello`{{execute}}

Check the list of functions in the application
`fn list f "lab${LAB_ID}"`{{execute}}

Time to invoke the function. The command for invoking the function is simply: `fn invoke <app-name> <function-name>`:

`fn invoke "lab$LAB_ID" hello`{{execute}}

The first call may take a while because of the cold start of the function. If you call the function a second and third time, it is bound to go a lot quicker. 

To send in a JSON object as input to the function, use the following command:

`echo -n '{"name":"Your Own Name"}' | fn invoke "lab${LAB_ID}" hello --content-type application/json`{{execute}}

Again, a friendly, this time personalized welcome message should be your reward - coming from the cloud.

Check out details for the function you just created and deployed:
`fn inspect f "lab$LAB_ID" hello`{{execute}}

## OCI Console 


Check in the OCI Console if the function shows up there:

## Function manipulation using OCI CLI

Execute this next script to learn the URL Endpoint to Invoke the Function and to get a URL that takes you directly to the OCI Console for the Function application.   
```
funsJ=$(fn inspect f  "lab$LAB_ID" hello)
funInvokeEndpoint=$(echo $funsJ | jq '."annotations"."fnproject.io/fn/invokeEndpoint"')
funId=$(echo $funsJ | jq --raw-output .id)
appId=$(echo $funsJ | jq --raw-output .app_id)
echo "Function Invoke Endpoint $funInvokeEndpoint"
echo "OCI Functions Console URL for Application lab$LAB_ID: https://console.us-ashburn-1.oraclecloud.com/functions/apps/$appId/fns"
```{{execute}}

Open the OCI Console in your browser using the URL shown in the terminal window. 

Alternatively, open [OCI Function Console](https://console.us-ashburn-1.oraclecloud.com/functions) and click on the application that you have just created.

Click on the function Hello in the Console. Check the metrics tab. You should see an indication of the number of times you have invoked the function. You can invoke the function a few additional times to see the effect on the metrics.



## Resources

See [OCI CLI Command Reference for Functions](https://docs.cloud.oracle.com/iaas/tools/oci-cli/2.8.0/oci_cli_docs/cmdref/fn.html)
List all functions in application:

`oci fn application list --compartment-id ocid1.compartment.oc1..aaaaaaaatxf2nfi7prglkhntadfj4tuxlfms36xhqc4hekuif6wjnoyq4ilq`{{execute}}


https://github.com/lucasjellema/oci-scripts/blob/master/functions/prepare-tenancy-for-functions.sh
https://thoughtbot.com/blog/jq-is-sed-for-json
https://jqplay.org/jq

Use jq to retrieve namespace name from JSON response to OCI CLI call:

nsJ=$(oci os ns get)
ns=$(echo $nsJ | jq .data)
echo "Namespace is $ns"

appsJ=$(oci fn application list --compartment-id ocid1.compartment.oc1..aaaaaaaatxf2nfi7prglkhntadfj4tuxlfms36xhqc4hekuif6wjnoyq4ilq)
appName=$(echo $appsJ | jq .data[0]'."display-name"')
appId=$(echo $appsJ | jq --raw-output .data[0]'."id"')
echo "https://console.us-ashburn-1.oraclecloud.com/functions/apps/$appId/fns"



    --compartment-id $FN_COMPARTMENT_OCID_VAR --all)
  local THE_VCN_ID=$(echo $vcns | jq -r --arg display_name "$1" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')

Invoke Function by Function (OC)Id:

oci fn function invoke --function-id ocid1.fnfunc.oc1.iad.aaaaaaaaach3r6tmq4qtn4xvxugdaotwdxuhczzxfjbahhmwn3ojlvzgykbq --body '{"name":"Jan"}' --file -


Get Function Invoke Endpoint:

fn inspect function lab-app hello


https://zmyrqeu5kgq.us-ashburn-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.iad.aaaaaaaaach3r6tmq4qtn4xvxugdaotwdxuhczzxfjbahhmwn3ojlvzgykbq/actions/invoke

