# Inspect and Invoke Function with OCI CLI

In this step we will inspect the function using the CLI and then invoke the function with the OCI CLI.

## Function inspection using OCI CLI

Execute this next script to learn the URL Endpoint to Invoke the Function and to get a URL that takes you directly to the OCI Console for the Function application.   

```
funsJ=$(fn inspect f  "lab$LAB_ID" "hello$LAB_ID")
funInvokeEndpoint=$(echo $funsJ | jq '."annotations"."fnproject.io/fn/invokeEndpoint"')
funId=$(echo $funsJ | jq --raw-output .id)
appId=$(echo $funsJ | jq --raw-output .app_id)

echo "Function Invoke Endpoint $funInvokeEndpoint"
echo "OCI Functions Console URL for Application lab$LAB_ID: https://console.us-ashburn-1.oraclecloud.com/functions/apps/$appId/fns"
```{{execute}}

Open the OCI Console in your browser using the URL shown in the terminal window. 

Click on the function Hello in the Console. Check the metrics tab. You should see an indication of the number of times you have invoked the function. You can invoke the function a few additional times to see the effect on the metrics.


## Invoke Function using OCI CLI

See [OCI CLI Command Reference for Functions](https://docs.cloud.oracle.com/iaas/tools/oci-cli/2.8.0/oci_cli_docs/cmdref/fn.html)

List all functions in application:

`oci fn application list --compartment-id $compartmentId`{{execute}}

Invoke function hello through the OCI CLI:

`oci fn function invoke --function-id $funId --body '{"name":"Jan"}' --file -  `{{execute}}

### Metrics

You can make a few additional calls. Then check in the Console if the metrics for these calls are coming through - both at application and at function level.



### Simple CURL Call will Fail

Note: a simple CURL call to the function will not work. Only a signed, authenticated request can be sent to the function on OCI. The following will fail:

`curl -X "POST" -H "Content-Type: application/json" -d '{"name":"Bob"}' $funInvokeEndpoint`{{execute}}

