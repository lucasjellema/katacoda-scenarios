# Streaming on OCI
In this scenario you will create work with the OCI [Event] Streaming Service - a managed Pub/Sub service, similar to Apache Kafka. Events are published to Streams (aka Topics) over HTTP calls and consumed from those Streams, again using HTTP calls. Consumption can be done from several starting point (at or from a specific offset, from a specific time, as much as is available, only new events) . Note that consumers have to actively come to the Streaming service and collect messages. There is no push mechanism that will trigger listeners whenever new messages have been published to the Stream. There is no concept of subscription: consumers just create a 'cursor' (somewhat similar to a session or a [long running] query) and start pulling messages in the context of that cursor.  

Streaming can be used for messaging, ingesting high-volume data such as application logs, operational telemetry, web click-stream data, or other use cases in which data is produced and processed continually and sequentially in a publish-subscribe messaging model.  Messages are retained for up to 7 days. There are limits on how much data a Stream can handle per second, but these limits are fairly high (1MB per partition per second, 1MB maximum message size, five consume calls per second).

The scenario uses an Ubuntu 18.04 environment with Docker, OCI CLI and Fn CLI. Before you can start the steps in the scenario, the two Command Line interfaces are downloaded and installed. This will take about one minute. You will need Postman as well, if you want to invoke the API Gateway directly from your computer.

The scenario expects a number of preparations:
* you already have deployed a function called *hello* in an application called lab# where # is a number assigned to you (in OCI compartment lab-compartment)
* an API Gateway already has been provided in compartment lab-compartment with permissions to access functions in this compartment; the API Gateway is associated with a public subnet 
* there is already an API Deployment on the API Gateway - called MY_API_DEPL#
* there already is a Stream in compartment lab-compartment, called lab-stream 

# Resources

Blog article introducing OCI Streaming [https://technology.amis.nl/2020/01/07/oracle-cloud-streaming-service-scalable-reliable-kafka-like-event-service-on-oci/]

Documentation on OCI Streaming Service: https://docs.cloud.oracle.com/iaas/Content/Streaming/Concepts/streamingoverview.htm

Blog article Todd Sharp: Getting your feet wet with Oracle Streaming: https://blogs.oracle.com/developers/getting-your-feet-wet-with-oci-streams