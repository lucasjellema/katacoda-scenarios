# Invoking Function from Postman (using a signed request) 

Postman can be used to make a request to a function OCI. The request has to be signed with the private key of an OCI user with the right access privileges. This [article](https://redthunder.blog/2019/07/10/calling-oci-apis-from-postman/) has a very good explanation of how Postman can be used for making requests to the Oracle Cloud Infrastructure REST APIs - in the proper way. In this section, we will make use of that knowledge to call our new function *hello#* in our own application *lab#*.

Details on all OCI REST APIs can be found in the [API Reference](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apiref.htm).