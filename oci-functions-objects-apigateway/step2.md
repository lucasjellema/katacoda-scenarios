# Creating a Node JS Application to Write Files on OCI Object Storage

OCI can be accessed through a console, through the OCI CLI and through REST APIs. Custom applications probably work most easily with this last option. In this step you will create (well, actually the code is already there, cloned from github and almost ready to execute) and test a Node JS application that writes files on OCI Object Storage. 

First, you need a to create a Bucket on OCI Object Storage. This *bucket* is similar to a folder or directory on a regular file system: a container to group files in. The Bucket is called oci-lab# - where # is the number you have been assigned for this workshop.

`oci os bucket create -c $compartmentId --name "oci-lab$LAB_ID"`{{execute}} 

The bucket is now created. Let's assign the bucket's OCID to an environment variable:

```
export bucketName="oci-lab$LAB_ID"
bucket=$(oci os bucket get --bucket-name $bucketName)
bucketOCID=$(echo $bucket | jq -r  '.data | .id')
echo "Bucket OCID for bucket $bucketName is $bucketOCID "
touch ~/oracle-cloud-native-meetup-20-january-2020/functions/file-writer/oci_api_key.pem 
```{{execute}}

Open file `~/oracle-cloud-native-meetup-20-january-2020/functions/file-writer/oci-configuration.js` in the text editor. Replace the current contents with the section provided to you by the workshop instructor. This file is used by the Node application to connect to the OCI REST APIs. It has to make signed HTTP requests - signed using the private key of an OCI User with necessary permissions on the OCI Object Storage.

Open file `~/oracle-cloud-native-meetup-20-january-2020/functions/file-writer/oci-api-key.pem. Copy the private key that the instructor provided to you into this file.

Navigate to the directory that contains the File Writer application:

`cd ~/oracle-cloud-native-meetup-20-january-2020/functions/file-writer`{{execute}}

and run `npm install` to install the required libraries.

`npm install`{{execute}} 

## Run the File Writer to create a new file on OCI Object Storage

Run the File Write application with the following command:

`node fileWriter '{"bucket":"oci-lab$LAB_ID","fileName":"secret.txt", "contents":{"File Contents":"Contents, Contents and more Contents"}}'`{{execute}}

Check the current contents of the bucket:

`oci os object list --bucket-name $bucketName`{{execute}}

Check in OCI Console for Object Storage: the bucket you have created and the file that should now be visible and manipulatable in the console: https://console.us-ashburn-1.oraclecloud.com/object-storage/buckets.

Retrieve the file that was just created:

`oci os object get  -bn $bucketName --name secret.txt --file secret-from-oci.txt`{{execute}}

Check contents of the file:
```
ls -l secret*
cat secret-from-oci.txt
```{{execute}}

At this point, we are capable of creating file objects on OCI Object Storage from a Node application. We can wrap this application in a Function that we can also deploy on OCI. That will be (y)our next step.

## Resources

A blog article: [Publish Oracle Function for Reading and Writing Object Storage Files through OCI API Gateway](https://technology.amis.nl/2020/01/05/publish-oracle-function-for-reading-and-writing-object-storage-files-through-oci-api-gateway/)
