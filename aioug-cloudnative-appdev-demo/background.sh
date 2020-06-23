#!/bin/bash

# start Docker Container with OCI 
mkdir ~/.oci
touch  ~/.oci/config
touch  ~/.oci/oci_api_key.pem



# install Project Fn CLI
curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh

touch /root/allSetInBackground

docker pull fnproject/node:latest

git clone https://github.com/lucasjellema/cloud-native-on-oci-aioug-june2020

