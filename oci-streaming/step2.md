# Listen to Events on Streams using OCI CLI

List all streams in the compartment *lab-compartment* :
`oci streaming admin stream list -c $compartmentId`{{execute}}

Let's get the details on stream *lab-stream*. 
```
streams=$(oci streaming admin stream list -c $compartmentId)
export streamId=$(echo $streams | jq -r --arg name "lab-stream" '.data | map(select(."name" == $name)) | .[0] | .id')
export streamMsgEndpoint=$(echo $streams | jq -r --arg name "lab-stream" '.data | map(select(."name" == $name)) | .[0] | ."messages-endpoint"')

oci streaming admin stream get --stream-id $streamId
```{{execute}}

Listening to a stream is done using a cursor. A cursor can be created through the OCI CLI, using this command:
```
streamCursor=$(oci streaming stream cursor create-cursor  --endpoint $streamMsgEndpoint --partition 0 --stream-id $streamId --type TRIM_HORIZON)
streamCursorId=$(echo $streamCursor | jq -r '.data |.value')
```{{execute}}

Note: values for type can be AFTER_OFFSET, AT_OFFSET, AT_TIME, LATEST, TRIM_HORIZON. The option TRIM_HORIZON specifies to return all messages from the Stream, LATEST would indicate only new messages. See [docs](https://docs.cloud.oracle.com/iaas/tools/oci-cli/2.8.0/oci_cli_docs/cmdref/streaming/stream/cursor/create-cursor.html)

To get messages from the stream using the cursor we have just created, execute this next command:

`oci streaming stream message get --cursor $streamCursorId --stream-id $streamId --endpoint $streamMsgEndpoint`{{execute}} 

Do not be disappointed that you do not actally see message content: the message is encoded as a Byte Array. When we start working with Node JS as a listener, we will decode the messages and make them readable.

Publish one or more test messages in the console. Then again:

`oci streaming stream message get --cursor $streamCursorId --stream-id $streamId --endpoint $streamMsgEndpoint`{{execute}} 

At least fresh timestamps should appear, even if you still cannot read the messages. 

