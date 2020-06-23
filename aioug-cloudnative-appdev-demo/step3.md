# Adding a Route in an API Deployment to am HTTP Backend

In this step, we will add a route to the API Deployment. This route will expose an HTTP_BACKEND. AN HTTP_BACKEND can be any HTTP endpoint, both within OCI or outside of it. API Gateway is in this case a simple router or reverse proxy.

`touch api_deployment_2.json`{{execute}}

Open file api_deployment_2.json in the text editor.

Copy the definitions of the routes */stock*, */search* and */countries* to the api_deployment_2.json file. You can open the file to check whether the change is applied correctly. Notice the second and third route, with path set to */search*. These routes are of type HTTP_BACKEND: it can route requests to a specific HTTP(S) endpoint, similar to what NGINX for exampe can do. 

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
    },
    {
      "path": "/countries",
      "methods": ["GET"],
      "backend": {
        "type": "HTTP_BACKEND",
        "url": "https://gist.githubusercontent.com/keeguon/2310008/raw/bdc2ce1c1e3f28f9cab5b4393c7549f38361be4e/countries.json"
      }
    }
  ]
}
</pre>


Update the API Deployment in API Gateway lab-apigw with the following command:  

`oci api-gateway deployment update --deployment-id $apiDeploymentId --specification file://./api_deployment_2.json`{{execute}}

Confirm - when prompted in the terminal - that you want to update, overwriting the existing specification.

It will take a few seconds (up to 15 seconds) for the API Gateway to synchronize its definition with the new specification. When the API Gateway deployment is updated, you can start using the new routes. 

You can check on the state of the API Deployment and the current update (called a *workrequest*) in the OCI Console. Execute this command to get the URL to the Console:

```echo "Your OCI Console Endpoint to inspect your API Deployment's current state: https://console.us-ashburn-1.oraclecloud.com/api-gateway/gateways/$apiGatewayId/deployments/$apiDeploymentId/workrequests"```{{execute}}


## Invoke the new routes on the API Deployment
Once the API Deployment has been updated you can now invoke the route that leads to the http backend exposed through *search*, using *curl*.

`curl $deploymentEndpoint/search`{{execute}}

[you can] Open this same URL in a browser window.

Invoke the route that leads to the file on GitHub.

`curl $deploymentEndpoint/countries`{{execute}}

Open the URL shown in the terminal window after executing the next command in a browser:
`echo "Open this URL in your browser: $deploymentEndpoint/countries"`{{execute}}
