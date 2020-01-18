# Creating a Function RSSFeeder that Leverages the File Writer API

In this step, you will create a function that invokes the File Writer to produce files on OCI Object Storage.

## Run the Node Application

Navigate to the directory that contains the RSSFeeder application:

`cd ~/oracle-cloud-native-meetup-20-january-2020/functions/rss-feeder`{{execute}}

and run `npm install` to install the required libraries.

`npm install`{{execute}} 

Make sure that the endpoint on the API Gateway where the File Writer function can be accessed is set in enviroment variable `file_writer_endpoint`.  

`export file_writer_endpoint="$deploymentEndpoint/write"`{{execute}}

Make sure $bucketName is set (to oci-lab#)

`node rssFeeder "https://technology.amis.nl/feed/" "amis-blog-rss.json"`{{execute}}

This will create a file called amis-blog-rss.json on Object Storage. It contains the actual contents from the AMIS Technology Blog's RSS Feed.

Check output

List objects in bucket:

`oci os object list --bucket-name $bucketName`{{execute}}


## Create, Deploy and Invoke a Function

We will now turn the Node application into a Function, just like we did with File Writer.

Check the contents of file `~/oracle-cloud-native-meetup-20-january-2020/functions/rss-feeder/func.js`. This file is the wrapper for the Fn Function around the RSSFeeder application.

````
cd ~/oracle-cloud-native-meetup-20-january-2020/functions/rss-feeder

cat func.js
```{{execute}}

Open the file *func.yaml* in the text editor. Change the name of the function from *rss-feeder* to *rss-feeder#* , where # is the LAB_ID you have neen assigned. 

Let's deploy this function to application `lab#`. Execute the next command - make sure you are in the correct directory.

`fn -v deploy --app "lab$LAB_ID"`{{execute}}

Make sure that the environment variables are set when RSSFeerder is executing. This is done by defining configuration settings for the function:
```
fn config function "lab$LAB_ID" rss-feeder$LAB_ID bucketName "$bucketName"
fn config function "lab$LAB_ID" rss-feeder$LAB_ID file_writer_endpoint "$file_writer_endpoint"
```{{execute}}

To invoke the function

`echo -n '{"rssFeedURL":"https://technology.amis.nl/feed/","filename":"another-amis-blog-rss.json"}' | fn invoke lab$LAB_ID rss-feeder$LAB_ID`{{execute}}

Check the current contents of the bucket:

`oci os object list --bucket-name $bucketName`{{execute}}

Check in OCI Console for Object Storage: the bucket you have created and the file that should now be visible and manipulatable in the console: https://console.us-ashburn-1.oraclecloud.com/object-storage/buckets.

Retrieve the file that was just created:

`oci os object get  -bn $bucketName --name another-amis-blog-rss.json --file large-json.txt`{{execute}}

Check contents of the file:
```
ls -l large-json*
cat large-json.txt
```{{execute}}

## Expose Function RSSFeeder on API Gateway

In this step, you will create a route to the RSSFeeder Function on OCI. 

```
apps=$(oci fn application list -c $compartmentId)
labApp=$(echo $apps | jq -r --arg display_name "lab$LAB_ID" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')

funs=$(oci fn function list --application-id $labApp)
fileWriterFun=$(echo $funs | jq -r --arg display_name "file-writer$LAB_ID" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
echo "OCID for file-writer$LAB_ID function : $fileWriterFun"
rssFeederFun=$(echo $funs | jq -r --arg display_name "rss-feeder$LAB_ID" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
echo "OCID for rss-feeder$LAB_ID function : $rssFeederFun"
```{{execute}}

Create the new file api_deployment2.json:

`touch api_deployment2.json`{{execute}}

Open the new file *api_deployment2.json* in the text editor and copy the definitions of the routes */rss*, */write* and */health* to the api_deployment.json file. The new /rss route accepts POST requests. The route is of type ORACLE_FUNCTIONS_BACKEND and has a Function as its target - the function rss-feeder. 

Replace the two occurrences of `function ocid` in the file with the OCIDs that were found just now for the RSSFeeder Function and the File Writer Function.

<pre class="file" data-filename="api_deployment2.json" data-target="append">
{
  "routes": [
    {
      "path": "/rss",
      "methods": ["POST"],
      "backend": {
        "type": "ORACLE_FUNCTIONS_BACKEND",
        "functionId": "function ocid"
      }
    },
    {
      "path": "/write",
      "methods": ["POST"],
      "backend": {
        "type": "ORACLE_FUNCTIONS_BACKEND",
        "functionId": "function ocid"
      }
    },
    {
      "path": "/health",
      "methods": ["GET"],
      "backend": {
        "type": "STOCK_RESPONSE_BACKEND",
        "body": "{\"status\":\"Up and Running\"}",
        "headers":[],
        "status":200
      }
    }
  ]
}
</pre>

Update the API Deployment in API Gateway lab-apigw with the following command:  

`oci api-gateway deployment update --deployment-id $apiDeploymentId --specification file://./api_deployment2.json`{{execute}}

It will take a few seconds (up to 15 seconds) for the API Gateway to synchronize its definition with the new specification. When the API Gateway deployment is updated, you can start using the new route. 

You can check on the state of the API Deployment and the current update (called a *workrequest*) in the OCI Console. Execute this command to get the URL to the Console:

```echo "Your OCI Console Endpoint to inspect your API Deployment's current state: https://console.us-ashburn-1.oraclecloud.com/api-gateway/gateways/$apiGatewayId/deployments/$apiDeploymentId/workrequests"```{{execute}}

## Invoke the RSSFeeder Function - Now publicly exposed through API Gateway

Using *curl* you can now invoke the route that leads to the function *rss-feeder* that you created in the previous step, and POST a file name and an RSS Feed URL to the function.

`curl -X "POST" -H "Content-Type: application/json" -d '{"rssFeedURL":"https://technology.amis.nl/feed/","filename":"amis-rss-through-api-gateway.json"}' $deploymentEndpoint/rss`{{execute}}

Check the current contents of the bucket:

`oci os object list --bucket-name $bucketName`{{execute}}

## Summary

In this step you have
* created a Node application that reads an RSS Feed and writes its contents as a File on OCI Object Storage - leveraging the File Writer function through the API Gateway
* turned that Node application into a Function and deployed it on OCI
* created a public endpoint for the function in API Gateway
* invoked the public endpoint on API Gateway using curl. No special authorization required. No special access privileges. 

