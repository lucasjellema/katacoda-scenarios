# Creating a Function Hello that Publishes an Event when Invoked

In this step, you will create a function Hello that publishes an event to Stream *lab-stream* when invoked.

## Run the Node Application

Navigate to the directory that contains the functions:

`cd ~/oracle-cloud-native-meetup-20-january-2020/functions`{{execute}}

Create a new function *hello* with this command:

`fn init --runtime node hello$LAB_ID`{{execute}}

Copy the sources from the stream-publisher application into the new function's directory:

`cp -R streams-pubsub/* ./hello$LAB_ID`{{execute}}

Change into the directory for the new function:

`cd ~/oracle-cloud-native-meetup-20-january-2020/functions/hello$LAB_ID`{{execute}}

Copy this dependency on the Fn Node handler to file *package.json* in the *hello#* directory (take good care of the commas to retain valid JSON):

```
		"@fnproject/fdk": ">=0.0.15"
```

and run `npm install` to install the required libraries.

`npm install`{{execute}} 

Open file *func.js* in the *hello* directory in the text editor. Add this line at the top - to import the stream-publisher module into func.js: 

`const pub=require('./stream-publisher')`

Copy and paste the next to lines to become lines 5 and 6 (inside the anonymous function passed to `fdk.handle()` ):
```
  const streamId = process.env["streamId"]
  pub.publish(streamId, [`Function Hello was invoked with input ${JSON.stringify(input)}`])
```

Deploy function *hello#*; this may overwrite an earlier version of the function:

`fn -v deploy --app "lab$LAB_ID"`{{execute}}

Make sure that the function as a meaningful value for environment variable streamId by setting it as configuration on the function:

`fn config function "lab$LAB_ID" hello$LAB_ID streamId $streamId`{{execute}}

Invoke the function:

`echo -n '{"name":"Your Own Name"}' | fn invoke "lab${LAB_ID}" hello$LAB_ID --content-type application/json`{{execute}}

Check in the Streaming console if the message was indeed published to the stream by the Function:

`echo "Console endpoint for Recent Messages on Stream lab-stream: https://console.us-ashburn-1.oraclecloud.com/storage/streaming/$streamId/recent-messages"`{{execute}}

or of course run the Stream Consumer we used before:

`node stream-consumer`{{execute}}

## Summary
You have seen how relatively easy it is to have a function publish messages to a Stream. Consuming messages from a stream is a similar feat. You could take the `stream-consumer.js` module and wrap it inside another new function. Note that this function is not triggered by new messages on the stream: you need to invoke the function to make it consume messages and act upon them as desired.
