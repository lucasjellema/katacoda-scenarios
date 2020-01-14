# Adding a Route in an API Deployment to am HTTP Backend

`touch api_deployment_2.json`{{execute}}

Open file api_deployment_2.json in the text editor.

Copy the definitions of the routes */stock* and */search* to the api_deployment_2.json file. You can open the file to check whether the change is applied correctly. Notice the second route, with path set to */search*. This route is of type HTTP_BACKEND: it can route requests to a specific HTTP(S) endpoint, similar to what NGINX for exampe can do. 

<pre class="file" data-filename="api_deployment_2.json" data-target="append">
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

`oci api-gateway deployment update --deployment-id $apiDeploymentId --specification file://./api_deployment_2.json`{{execute}}

Using *curl* you can now invoke the route that leads to the function *search* that you created in a previous scenario.

`curl $deploymentEndpoint/search`{{execute}}

[you can] Open this same URL in a browser window.