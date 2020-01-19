# Create OCI Resources

The workshop environment works with participants (users) who are member of a group called *lab-participants* . Create that group:

```
group=$(oci iam group create --name "lab-participants"  --description "Group for participants in Cloud Native workshop")
echo $group
export groupId=$(echo $group | jq --raw-output .data.id)
echo $groupId
export groupName="lab-participants"
```{{execute}}

If group already exists:
```
gs=$(oci iam group list)
export groupId=$(echo $gs | jq -r --arg display_name "lab-participants" '.data | map(select(."name" == $display_name)) | .[0] | .id')
```{{execute}}


Lab environment uses a compartment called *lab-compartment*:

```
compartment=$(oci iam compartment create --compartment-id "$TENANCY_OCID"  --name "lab-compartment" --description "Compartment for resources for Cloud Native workshop")
echo $compartment
compartmentId=$(echo $compartment | jq --raw-output .data.id)
echo $compartmentId
```{{execute}}

If compartment already exists:
```
cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')
```{{execute}}



 (Compartment, VCN, API Gateway, Stream)

## Create VCN

Run OCI Networking Quickstart wizard in the context of compartment *lab-compartment*  – to create VCN, subnets, internet gateway, NAT gateway, service gateway.

Note: this wizard is available in the OCI Console: https://console.us-ashburn-1.oraclecloud.com/networking/vcns 

Use as the name of the VCN: *vcn-lab*. Accept all examples for CIDR blocks and default settings elsewhere. 

When the wizard is done, run this statement to retrieve the OCID:
```
vcns=$(oci network vcn list  --compartment-id $compartmentId --all)
export vcnId=$(echo $vcns | jq -r --arg display_name "vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')
echo "$vcnId"
subnets=$(oci network subnet list  -c $compartmentId --vcn-id $vcnId)
export subnetId=$(echo $subnets | jq -r --arg display_name "Public Subnet-vcn-lab" '.data | map(select(."display-name" == $display_name)) | .[0] | .id')

sls=$(oci network security-list list  -c $compartmentId --vcn-id $vcnId)
export slOCID=$(echo $sls | jq -r '.data | .[0] | .id')

```{{execute}}

Add network security rule to allow inbound traffic to public subnet on port 443
(https://technology.amis.nl/2019/12/23/my-first-steps-with-oracle-cloud-api-gateway-the-stock-response/)

Open the console for the security list:
`echo "Open the console at https://console.us-ashburn-1.oraclecloud.com/networking/vcns/$vcnId/security-lists/$slOCID"
`{{execute}}

Press *Add Ingress Rule*. Specify source CIDR as 0.0.0.0/0 (anything goes) and set *Source Port Range* to *All*. Set *Destination Port Range* to *443*. Leave the IP protocol at the default of *TCP*. Press *Add Ingress Rule*.


## Create API Gateway

Create an API Gateway called *lab-apigw*. 
`oci api-gateway gateway create --compartment-id $compartmentId --endpoint-type PUBLIC  --display-name lab-apigw --subnet-id $subnetId `{{execute}}

Retrieve the Gateway OCID
```
apigws=$(oci api-gateway gateway list -c $compartmentId)
export apiGatewayId=$(echo $apigws | jq -r --arg display_name "lab-apigw" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')
```{{execute}}



Create a Dynamic Group through Console to allow API Gateway access to functions - called *lab-apigw-dynamic-group*
https://console.us-ashburn-1.oraclecloud.com/identity/dynamicgroups

Create a rule for dynamic group

ALL {resource.type = 'ApiGateway', resource.compartment.id = 'OCID compartment lab-compartment'}
`oci iam dynamic-group create --compartment-id $TENANCY_OCID --name "lab-apigw-dynamic-group" --description "to collect API Gateways in Compart lab-compartment"  --matching-rule "[ \"ALL {resource.type = 'ApiGateway', resource.compartment.id = '$compartmentId'}\"]" `{{execute}}

## Create Stream

Create a stream called *lab-stream* :

`oci streaming admin stream create --name "lab-stream" -c $compartmentId --partitions 1`{{execute}}

