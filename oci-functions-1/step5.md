# Creating a Function that Leverages the File Writer API

In this step, you will create a function that invokes the File Writer to produce files on OCI Object Storage.

## Run the Node Application

The Node Application RSSFeeder in 

npm install

export file_writer_endpoint="$deploymentEndpoint/write"

Make sure $bucketName is set (to oci-lab#)

node rssFeeder "https://technology.amis.nl/feed/" "amis-blog-rss.json"

Check output

Check in Console:

List objects in bucket:

`oci os object list --bucket-name $bucketName`{{execute}}


## Create, Deploy and Invoke a Function

## Expose Function on API Gateway