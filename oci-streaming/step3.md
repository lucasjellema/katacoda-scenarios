# Node Application as OCI Stream Consumer

OCI can be accessed through a console, through the OCI CLI and through REST APIs. Custom applications probably work most easily with this last option. In this step you will create (well, actually the code is already there, cloned from github and almost ready to execute) and test a Node JS application that consumes messages from the OCI Stream *lab-stream*. 

Open file `~/oracle-cloud-native-meetup-20-january-2020/functions/streams-pubsub/oci-configuration.js` in the text editor. Replace the current contents with the section provided to you by the workshop instructor. This file is used by the Node application to connect to the OCI REST APIs. It has to make signed HTTP requests - signed using the private key of an OCI User with necessary permissions on the OCI Object Storage.

Open file `~/oracle-cloud-native-meetup-20-january-2020/functions/streams-pubsub/oci-api-key.pem. Copy the private key that the instructor provided to you into this file.

Navigate to the directory that contains the Stream application:

`cd ~/oracle-cloud-native-meetup-20-january-2020/functions/streams-pubsub`{{execute}}

and run `npm install` to install the required libraries.

`npm install`{{execute}} 

## Run the Stream Consumer to consume all current messages on OCI Stream lab-stream

Run the Stream Consume application with the following command:

`node stream-consumer`{{execute}}

This application creates a cursor on the *lab-stream* with TRIM_HORIZON set - meaning all messages on the Stream. It then reads messages from the cursor and writes them to the console.

You may want to check the code that reads from the Stream. It is in file *streams-pubsub.js*.

Note the following lines
```
    let buff = new Buffer.from(e.value, 'base64');
    let text = buff.toString('ascii');
    log( text)
```

that take care of decoding (from  Base64 en from ByteArray format) the message payload.

Go to the OCI Console (as lab-user at: https://console.us-ashburn-1.oraclecloud.com/storage/streaming) and publish a few test messages on *lab-stream*. Then run the Node application another time - and watch the fresh messages come in.

`node stream-consumer`{{execute}}

You could change the constant CURSOR_TYPE from TRIM_HORIZON (all messages) to LATEST (only messages published after the cursor was created). Run the application again - and again - to only see new messages.


## Resources

A blog article: [Oracle Cloud Streaming Service – Scalable, Reliable, Kafka-like Event service on OCI](https://technology.amis.nl/2020/01/07/oracle-cloud-streaming-service-scalable-reliable-kafka-like-event-service-on-oci)


