# Creating a Node JS Application to Write Files on OCI Object Storage

OCI can be accessed through a console, through the OCI CLI and through REST APIs. Custom applications probably work most easily with this last option. In this step you will create (well, actually the code is already there, cloned from github and almost ready to execute) and test a Node JS application that writes files on OCI Object Storage. 

First, you need a to create a Bucket on OCI Object Storage. This *bucket* is similar to a folder or directory on a regular file system: a container to group files in. The Bucket is called oci-lab# - where # is the number you have been assigned for this workshop.

`oci os bucket create -c $compartmentId --name "oci-lab$LAB_ID"`{{execute}} 

The bucket is now created. Let's assign the bucket's OCID to an environment variable:

```
buckets=$(oci os bucket list -c $compartmentId)
echo $buckets
bucketName="oci-lab$LAB_ID"
bucketOCID=$(echo $depls | jq -r --arg display_name $bucketName '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')
echo "Bucket OCID for bucket $bucketName is $bucketOCID "

```{{execute}}



## Resources

A blog article: [Publish Oracle Function for Reading and Writing Object Storage Files through OCI API Gateway](https://technology.amis.nl/2020/01/05/publish-oracle-function-for-reading-and-writing-object-storage-files-through-oci-api-gateway/)
