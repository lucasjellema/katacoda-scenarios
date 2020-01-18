# OCI Tenancy

The Katacoda workshop scenarios on OCI require an OCI environment to be prepared. This environment is set up in an OCI Tenancy. This can be an existing, paid for OCI Tenancy, or a Tenancy created as a Free Trial.

If you do not currently have access to an OCI Tenancy, you could have an environment provisioned for you as part of a 30-day free trial. You will need the following:

* an email address
* a mobile phone to receive a confirmation code per SMS
* a credit card (the trial really is free, but you need to record payment details all the same)

Then goto https://www.oracle.com/cloud/free/ and click on *Start for free* to sign up for a free trial.

You will define a cloudaccount (name of the tenancy), your username and a password. You also need to select a Region; this could be one close to you or one that has the services available you want to look at. For the workshop scenarios on Katacoda, the safest bet is to go with region Ashburn.

The next steps can be performed by the user who is the tenancy owner or by another user who is member of Administrators Group.

## Prepare Key Pair for User

The user who will setup the workshop environment needs to be configured in OCI with a key pair; the public key should be uploaded into the OCI Console (https://console.us-ashburn-1.oraclecloud.com/a/identity/users ). The private key should be kept private (not stored in OCI). You need this private key to make the OCI CLI work with OCI as the intended user. You also need the fingerprint for the user's key.

Oracle Cloud docs on generating the key pair: https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm.

Make sure that the destination directory already exists:
`mkdir ~/.oci`{{execute}}

Then generate the key pair:

```
openssl genrsa -out ~/.oci/oci_api_key.pem 2048
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem
```{{execute}}

Upload the public key (contents of file /.oci/oci_api_key_public.pem) to the user in the OCI Cloud Console. Save the private key (file *~/.oci/oci_api_key.pem*) in a safe location.

If you need the fingerprint for the key, it can be retrieved using:
`openssl rsa -pubout -outform DER -in ~/.oci/oci_api_key.pem | openssl md5 -c`{{execute}}

See https://technology.amis.nl/2018/10/14/get-going-quickly-with-command-line-interface-for-oracle-cloud-infrastructure-using-docker-container/ for some background. 

### If there already is a key pair...

If the key pair was previously created and the public key uploaded to OCI, you do not need to create a new key. However, you need to add the Private Key of the Tenancy Owner or Admin user to the file `oci_api_key.pem`. 

## Edit Config File

Open file *~/.oci/config* in the text editor.
<pre class="file" data-filename="config" data-target="append">
[DEFAULT]
user=OCID FOR YOUR TENANCY OWNER USER OR OTHER ADMIN USER
fingerprint=FINGERPRINT FOR KEY FOR USER
key_file=/root/.oci/oci_api_key.pem
tenancy=OCID FOR YOUR TENANCY
region=us-ashburn-1
</pre>

Try out the following command to get a list of all namespaces you currently have access to - based on the OCI Configuration defined above.

`oci os ns get`{{execute}} 

If this command gives a proper response, the configuration is most likely correct.

Another test:

`oci iam user get  --user-id OCID`{{execute}}

Please replace OCID with the OCID for the tenancy owner or the administrator that you are currently using. This should return details about the current user.

Set an environment variable with Tenancy OCID (visible here: https://console.us-ashburn-1.oraclecloud.com/a/tenancy/regions ):

`export TENANCY_OCID=`{{execute}}