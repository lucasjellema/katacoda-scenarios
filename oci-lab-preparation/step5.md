# Cleanup

This step runs a script with  OCI CLI statements to clean up after a cloud native lab participant.

A participant 
* works in a compartment called *lab-compartment*
* uses an API Gateway called *lab-apigw*

A participant has a number assigned: #
* works in a private bucket on Object Storage called *oci-lab#*
* creates a function app on Functions called *lab#*
* creates an API Deployment (on API Gateway lab-apigw) called *MY_API_DEPL_#*

When we clean up, we should remove (functions and applications, API deployment, objects/files and buckets ):

* all functions in compartment lab-compartment (all functions in all apps in that compartment) (or all functions in app# in the compartment)
* all API Deployments on API Gateway lab-apigw (or API Deployment MY_API_DEPL_#)
* all objects in and all buckets called oci-lab* (all objects in bucket oci-lab# as well as bucket oci-lab#)

optionally:
* all health checks in lab-compartment
* all alarm definitions in lab-compartment
* function images



