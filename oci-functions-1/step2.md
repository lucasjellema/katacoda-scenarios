# Creating an API Deployment on an API Gateway on OCI

Let's find out about the API Gateway *lab-apigw* that we will be using in this step:

`oci api-gateway gateway get --gateway-id $apiGatewayId`{{execute}}

There should not be an API Deployment at this stage. Let's list all gateway deployments in the :
`oci api-gateway deployment list -c $compartmentId  --gateway-id $apiGatewayId`{{execute}}

Note: if you feel that it is difficult to read the output from these commands, you could consider piping the output to a text file that you can subequently browse in *vi*. For example:

```
oci api-gateway deployment list -c $compartmentId  --gateway-id $apiGatewayId > apiGWDepl
vi apiGWDepl
```{{execute}}

Exit vi using <kbd>Esc</kbd>q<kbd>!</kbd>.


Create your own API Deployment - with a single route, to a stock response (a route with a static response object).

Create a file called api_deployment.json in the current directory with this contents. Note: replace $funId with the actual OCID for the function.

`touch api_deployment.json`{{execute}}

Copy the definition of the route */stock* to the api_deployment.json file:

<pre class="file" data-filename="api_deployment.json" data-target="append">
{
  "routes": [
    {
      "path": "/stock",
      "methods": ["GET"],
      "backend": {
        "type": "STOCK_RESPONSE_BACKEND",
        "body": "{\"special_key\":\"Special Value\"}",
        "headers":[],
        "status":200
      }
    }
  ]
}
</pre>

Create the API Deployment in API Gateway lab-apigw with the following command:  

`oci api-gateway deployment create --compartment-id $compartmentId --display-name MY_API_DEPL_$LAB_ID --gateway-id $apiGatewayId --path-prefix "/my-depl$LAB_ID" --specification file://./api_deployment.json`{{execute}}

Now you can invoke the new API:

ENDPOINT of API Gateway/my-depl$LAB_ID/stock

`curl https://e5j4rf662bdczha6kdptqp35xa.apigateway.us-ashburn-1.oci.customer-oci.com/my-depl1`{{execute}}


## Adding a Route to a Serverless Function as a Backend

`touch api_deployment_2.json`{{execute}}

Copy the definitions of the routes */stock* and */hello* to the api_deployment_2.json file:

<pre class="file" data-filename="api_deployment_2.json" data-target="append">
{
  "routes": [
    {
      "path": "/hello",
      "methods": ["GET","POST"],
      "backend": {
        "type": "ORACLE_FUNCTIONS_BACKEND",
        "functionId": "$funId"
      }
    },
    {
      "path": "/stock",
      "methods": ["GET"],
      "backend": {
        "type": "STOCK_RESPONSE_BACKEND",
        "body": "{\"special_key\":\"Special Value\"}",
        "headers":[],
        "status":200
      }
    }
  ]
}
</pre>

Update the API Deployment in API Gateway lab-apigw with the following command:  

`oci api-gateway deployment update --deployment-id $apiDeploymentId --specification file://./api_deployment_2.json`{{execute}}

Using *curl* you can now invoke the route that leads to the function *hello* that you created in a previous scenario.

helloEndpoint=https://e5j4rf662bdczha6kdptqp35xa.apigateway.us-ashburn-1.oci.customer-oci.com/my-depl1/hello
`curl -X "POST" -H "Content-Type: application/json" -d '{"name":"Bob"}' $helloEndpoint`{{execute}}


See the documentation on [Deploying an API on an API Gateway by Creating an API Deployment](https://docs.cloud.oracle.com/iaas/Content/APIGateway/Tasks/apigatewaycreatingdeployment.htm) and (Create a Specification)[https://docs.cloud.oracle.com/iaas/Content/APIGateway/Tasks/apigatewaycreatingspecification.htm].


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

