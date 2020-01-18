#!/bin/bash

mkdir ~/.oci
touch  ~/.oci/config
touch  ~/.oci/oci_api_key.pem

# Install the OCI CLI in silent mode with default settings
curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh > install-oci-cli.sh
chmod +777 install-oci-cli.sh
./install-oci-cli.sh --accept-all-defaults

touch /root/allSetInBackground

# install Project Fn CLI
curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh

docker pull fnproject/node:latest

fn create context lab-fn-context --provider oracle

fn use context lab-fn-context

cs=$(oci iam compartment list)
export compartmentId=$(echo $cs | jq -r --arg display_name "lab-compartment" '.data | map(select(."name" == $display_name)) | .[0] | .id')
# get namespace
nss=$(oci os ns get)
export ns=$(echo $nss | jq -r '.data')


fn update context oracle.compartment-id $compartmentId

fn update context api-url https://functions.us-ashburn-1.oci.oraclecloud.com

fn update context registry iad.ocir.io/$ns/cloudlab-repo

fn update context oracle.profile FN

