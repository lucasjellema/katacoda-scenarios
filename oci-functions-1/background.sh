#!/bin/bash

mkdir ~/.oci
touch  ~/.oci/config
touch  ~/.oci/oci_api_key.pem

# Install the OCI CLI in silent mode with default settings
curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh > install-oci-cli.sh
chmod +777 install-oci-cli.sh
./install-oci-cli.sh --accept-all-defaults

touch /root/readyWithBackground

# install Project Fn CLI
curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh

docker pull fnproject/node:latest

fn create context lab-fn-context --provider oracle

fn use context lab-fn-context

compartmentId=ocid1.compartment.oc1..aaaaaaaag4mbmj22ecmbbf43fjgzo4sd5vtldwbdq7z67p34p7xipkwfhzta
apiGatewayId=ocid1.apigateway.oc1.iad.amaaaaaa6sde7caaqh7lrxdlijuxxju66zpeycuy2qi72sggv6lgp7yvky4a

depls=$(oci api-gateway deployment list -c $compartmentId)
deploymentEndpoint=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .endpoint')
apiDeploymentId=$(echo $depls | jq -r --arg display_name "MY_API_DEPL_$LAB_ID" '.data.items | map(select(."display-name" == $display_name)) | .[0] | .id')

fn update context oracle.compartment-id $compartmentId

fn update context api-url https://functions.us-ashburn-1.oci.oraclecloud.com

fn update context registry iad.ocir.io/idtwlqf2hanz/cloudlab-repo

fn update context oracle.profile FN

