#!/bin/bash

# start Docker Container with OCI 
mkdir ~/.oci
touch  ~/.oci/config
touch  ~/.oci/oci_api_key.pem


# Install the OCI CLI in silent mode with default settings
curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh > install-oci-cli.sh
chmod +777 install-oci-cli.sh
./install-oci-cli.sh --accept-all-defaults

touch /root/allSetInBackground



