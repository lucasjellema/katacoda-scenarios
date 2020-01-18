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

users=$(oci iam user list -c $TENANCY_OCID --all)
# look for user lab-user
export userId=$(echo $users | jq -r --arg display_name "lab-user" '.data | map(select(."name" == "lab-user")) | .[0] |.id') 

create password for lab-user, change upon first login:
```
passwordJS=$(oci iam user ui-password create-or-reset --user-id  "$userId")  
password=$(echo $passwordJS | jq --raw-output .data.password)
echo "Password: $password"
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

# Compose document with all required credentials for lab-user

At this point it would be most convenient if you can compile a document with all relevant credentials for the lab-user, to hand out to lab participants. This document should contain:

* tenancy name (for example *labuser2*)
* private key (contents from file lab-user-oci_api_key.pem)
* config file with tenancy ocid, user ocid, fingerprint, region and reference to private key file
* console login password 
* OCIR docker username and password (namespace/lab-user and generated auth token)

```
echo "Here comes namespace" 
oci os ns get
echo "Tenancy OCID: $TENANCY_OCID"
echo "User OCID for user lab-user: $userId"
echo "Password: $password"
echo "Auth Token: $authToken"

touch ./lab-user-credentials.txt
```{{execute}}

Open file lab-user-credentials.txt - and add the text fragment below:

<pre class="file" data-filename="lab-user-credentials.txt" data-target="append">
## OCI Console Login

username: lab-user
password: 

## OCIR (Docker) Login

username: namespace/lab-user
password: Auth Token

## OCI CLI Config File

[DEFAULT]
user=OCID User lab-user
fingerprint=fingerprint key lab-user
key_file=/root/.oci/oci_api_key.pem
tenancy=Tenancy OCID
region=us-ashburn-1

## Private Key

!!Copy contents from ~/.oci/lab-user-oci_api_key.pem
-----BEGIN RSA PRIVATE KEY-----
... REPLACE with a real Private Key
-----END RSA PRIVATE KEY-----
</pre>

