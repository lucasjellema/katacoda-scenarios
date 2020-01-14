# Adding a Route in an API Deployment to a Serverless Function as a Backend

In this step, you will create a route to a serverless Function on OCI. We will create a route to function *hello* - that was created in the previous scenario. The function OCID for this function *hello* (in application *lab#<your lab participant number>* can be retrieved as follows:

```
apps=$(oci fn application list -c $compartmentId)
labApp=$(echo $apps | jq -r --arg display_name "lab$LAB_ID" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')

funs=$(oci fn function list --application-id $labApp)
helloFun=$(echo $funs | jq -r --arg display_name "hello" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
echo "OCID for hello function : $helloFun"
```{{execute}}

Create the new file api_deployment_3.json:

`touch api_deployment_3.json`{{execute}}

Open the new file *api_deployment_3.json* in the text editor and copy the definitions of the routes */stock*,*/search* and */hello* to the api_deployment_3.json file. The /hello route is new compared to the previous step. This route accepts both GET and POST requests - but not PUT, DELETE and others. The route is of type ORACLE_FUNCTIONS_BACKEND and has a Function as its target. In this case, we want this route to invoke function *hello* in application lab#. 

Replace `<function ocid>` in the file with the OCID that was found just now.

<pre class="file" data-filename="api_deployment_3.json" data-target="append">
{
  "routes": [
    {
      "path": "/hello",
      "methods": ["GET","POST"],
      "backend": {
        "type": "ORACLE_FUNCTIONS_BACKEND",
        "functionId": "<function ocid>"
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
    },
    {
      "path": "/search",
      "methods": ["GET"],
      "backend": {
        "type": "HTTP_BACKEND",
        "url": "https://www.startpage.com/"
      }
    }
  ]
}
</pre>

Update the API Deployment in API Gateway lab-apigw with the following command:  

`oci api-gateway deployment update --deployment-id $apiDeploymentId --specification file://./api_deployment_3.json`{{execute}}

It will take a few seconds (up to 15 seconds) for the API Gateway to synchronize its definition with the new specification. When the API Gateway deployment is updated, you can start using the new route. 

Using *curl* you can now invoke the route that leads to the function *hello* that you created in a previous scenario, and POST an input message to the function.

`curl -X "POST" -H "Content-Type: application/json" -d '{"name":"Bob"}' $deploymentEndpoint/hello`{{execute}}

Feel free to invoke the function in Postman and/or in your Browser, using its endpoint:

`echo "Function Hello's Endpoint $deploymentEndpoint/hello"`{{execute}}