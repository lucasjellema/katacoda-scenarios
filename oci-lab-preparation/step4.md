# Prepare lab-user

In this step you will create the user *lab-user*.

A new user has no permissions until you place the user in one or more groups (see AddUserToGroup). 
If the user needs to access the Console, you need to provide the user a password. 
If the user needs to access the Oracle Cloud Infrastructure REST API, you need to upload a public API signing key for that user (see Required Keys and OCIDs and also UploadApiKey).
In order to be able to deploy function, a user needs an AuthToken to use for logging into to OCIR (Container Registry)

```
user=$(oci iam user create --name "lab-user" --description "OCI user for Cloud Native Lab Assignments"  --email "lucasjellema@gmail.com" )  
echo $user
userId=$(echo $user | jq --raw-output .data.id)
echo $userId
```{{execute}}

In case the user already exists, the user OCID can be retrieved like this:

oci iam user list -c $compartmentId

create password for lab-user, change upon first login:
```
passwordJS=$(oci iam user ui-password create-or-reset --user-id  "$userId")  
echo "Password: $(echo $passwordJS | jq --raw-output .data.password)"
```{{execute}}

assigning user lab-user to group lab-participants

`oci iam group add-user --group-id "$groupId" --user-id "$userId" `{{execute}}

Check on group and member:
`echo "URL to Group in OCI Console https://console.us-ashburn-1.oraclecloud.com/identity/groups/$groupId"`{{execute}}


## Generate and Upload Key

```
#private key:
openssl genrsa -out ~/.oci/lab-user-oci_api_key.pem 2048

#public key:
openssl rsa -pubout -in ~/.oci/lab-user-oci_api_key.pem -out ~/.oci/lab-user-oci_api_key_public.pem

#fingerprint:
openssl rsa -pubout -outform DER -in ~/.oci/lab-user-oci_api_key.pem | openssl md5 -c > lab-user-fingerprint

oci iam user api-key upload --user-id $userId  --key-file ~/.oci/lab-user-oci_api_key_public.pem
```{{execute}}

Hold on to the Private Key - make sure to save it somewhere for reuse.
`cat ~/.oci/lab-user-oci_api_key.pem`{{execute}}

## Generate Auth Token for logging into Docker Container Registry


```
authTokenJS=$(oci iam auth-token create --description "Token for logging in into Docker/OCR" --user-id $userId)
echo $authTokenJS
authToken=$(echo $authTokenJS | jq --raw-output .data.token)
echo $authToken
```{{execute}}

Save this auth token for user *lab-user* for use later on.