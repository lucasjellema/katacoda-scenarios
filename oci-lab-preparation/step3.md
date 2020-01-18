# Create Policies

Create policies to assign privileges to group *lab-participants*  

Prepare some environment variables
```
FN_DEVS_GROUP="lab-participants"
FN_MANAGE_APP_POLICY=lab-app-management
FN_GROUP_USE_VCN_POLICY=lab-group-use-network-family
FN_FAAS_USE_VCN_POLICY=lab-faas-use-network-family
FN_FAAS_READ_REPOS_POLICY=lab-faas-read-repos
```{{execute}}

Policies granting to *lab-participants* for Functions (FAAS) to access compartment, container repos, Network, compartment
```
oci iam policy create  --name lab-repos-management --compartment-id $TENANCY_OCID  --statements "[ \"Allow group $FN_DEVS_GROUP to manage repos in tenancy\"]"  --description "policy for granting rights to $FN_DEVS_GROUP to manage Repos in tenancy"

echo creating policy $FN_FAAS_USE_VCN_POLICY
oci iam policy create  --name $FN_FAAS_USE_VCN_POLICY --compartment-id $TENANCY_OCID  --statements "[ \"Allow service FaaS to use virtual-network-family in compartment lab-compartment\"]"  --description "Create a Policy to Give the Oracle Functions Service Access to Network Resources"

echo creating policy $FN_FAAS_READ_REPOS_POLICY
oci iam policy create  --name $FN_FAAS_READ_REPOS_POLICY --compartment-id $TENANCY_OCID  --statements "[ \"Allow service FaaS to read repos in tenancy\"]"  --description "Create a Policy to Give the Oracle Functions Service Access to Repositories in Oracle Cloud Infrastructure Registry"


oci iam policy create  --name $FN_MANAGE_APP_POLICY --compartment-id $compartmentId  --statements "[ \"Allow group $FN_DEVS_GROUP to manage functions-family in compartment lab-compartment\",
\"Allow group $FN_DEVS_GROUP to read metrics in compartment lab-compartment\"]" --description "policy for granting rights to $FN_DEVS_GROUP to manage Function Apps in compartment lab-compartment"

echo creating policy $FN_GROUP_USE_VCN_POLICY
oci iam policy create  --name $FN_GROUP_USE_VCN_POLICY --compartment-id $compartmentId  --statements "[ \"Allow group $FN_DEVS_GROUP to use virtual-network-family in compartment lab-compartment\"]"  --description "Create a Policy to Give Oracle Functions Users Access to Network Resources in compartment lab-compartment"
```{{execute}}



