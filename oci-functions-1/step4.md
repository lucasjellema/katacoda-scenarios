# Adding a Route in an API Deployment to a Serverless Function as a Backend

`touch api_deployment_3.json`{{execute}}

Copy the definitions of the routes */stock*,*/search* and */hello* to the api_deployment_3.json file:

<pre class="file" data-filename="api_deployment_3.json" data-target="append">
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

Using *curl* you can now invoke the route that leads to the function *hello* that you created in a previous scenario.

helloEndpoint=https://e5j4rf662bdczha6kdptqp35xa.apigateway.us-ashburn-1.oci.customer-oci.com/my-depl1/hello
`curl -X "POST" -H "Content-Type: application/json" -d '{"name":"Bob"}' $helloEndpoint`{{execute}}

