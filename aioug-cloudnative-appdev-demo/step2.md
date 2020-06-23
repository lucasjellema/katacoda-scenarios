# Deploy Function

`cd /root/cloud-native-on-oci-aioug-june2020/functions/tweet-report-processor` 
`nom install`{{execute}}

`fn -v deploy --app "lab$LAB_ID"`{{execute}}


`fn invoke "lab$LAB_ID" tweet-report-processor`{{execute}}