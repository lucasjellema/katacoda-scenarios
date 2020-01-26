# JQ 
https://jqplay.org/


Load JSON data into variable

`countries=$(curl https://restcountries.eu/rest/v2/all)`{{execute}} 

Get details on The Netherlands

`netherlands=$(echo $countries | jq -r --arg countryAlpha2Code "NL" '. | map(select(."alpha2Code" == "$countryAlpha2Code")) | .[0] | .')`{{execute}} 


If this command gives a proper response, the configuration is most likely correct.

Another test:

`oci iam user get  --user-id OCID`{{execute}}

Please replace OCID with the OCID for the tenancy owner or the administrator that you are currently using. This should return details about the current user.

Set an environment variable with Tenancy OCID (visible here: https://console.us-ashburn-1.oraclecloud.com/a/tenancy/regions ):

`export TENANCY_OCID=`{{execute}}