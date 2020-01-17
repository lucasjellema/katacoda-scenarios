# Publishing Messages to OCI Streaming

In this step you will create (well, actually the code is already there, cloned from github and almost ready to execute) and test a Node JS application that publishes messages to the OCI Stream *lab-stream*. 

## Run the Stream Publisher to publish a message to the OCI Stream lab-stream

Run the Stream Publish application with the following command:

`node stream-publisher 'My Message - to be published to the Stream'`{{execute}}

This will execute the REST API call to will publish the messages to stream *lab-stream*.

You can verify the success of the call by checking in the console:
`echo "Console endpoint for Recent Messages on Stream lab-stream: https://console.us-ashburn-1.oraclecloud.com/storage/streaming/$streamId/recent-messages"`{{execute}}

or of course run the Stream Consumer from the previous step:

`node stream-consumer`{{execute}}

Feel free to publish a second message:

`node stream-publisher 'A second message - much better than the first one'`{{execute}}

And check if it was published as expected:

`node stream-consumer`{{execute}}