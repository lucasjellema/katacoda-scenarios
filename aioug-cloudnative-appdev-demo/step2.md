# Run Tweet Report Processor locally

`cd /root/cloud-native-on-oci-aioug-june2020/functions/tweet-report-processor`{{execute}}
`npm install`{{execute}}

Feel free to replace filename with any other file name (that is in Object Storage, bucket tweet-reports)
`node index.js "tweets-Ajax-2020-06-22T09:52:48.json"`{{execute}} 

# Deploy Function

Deploy the Function

`fn -v deploy --app "lab$LAB_ID"`{{execute}}

Invoke the function

`echo -n '{"filename":"tweets-Ajax-2020-06-22T09:52:48.json"}' | fn invoke "lab${LAB_ID}" "tweet-report-processor" --content-type application/json`{{execute}}

If the Event has been defined for creation of object in Object Storage, bucket tweet-reports and it publishes on a Notification Topic and the Function has been subscribed to that topic, then a call to 

https://a7otzunjmey252aivwp2gfhrfq.apigateway.us-ashburn-1.oci.customer-oci.com/my-depl1/consume-tweets?hashtag=aioug&minutes=200

should result:
1. in a JSON document on Object Storage
2. in messages on the Streaming Topic
3. in new records in the NoSQL database 