#!/bin/bash

touch /root/createdFromBackgroundScript
# start Docker Container with OCI 
mkdir ~/.oci
docker pull stephenpearson/oci-cli:latest
docker pull fnproject/fnserver:latest
#docker run --rm --mount type=bind,source=$HOME/.oci,target=/root/.oci  stephenpearson/oci-cli:latest 
#setup config
#
# add this line to ~/.profile
# oci() { docker run --rm --mount type=bind,source=$HOME/.oci,target=/root/.oci stephenpearson/oci-cli:latest "$@"; }
echo 'oci() { docker run --rm --mount type=bind,source=$HOME/.oci,target=/root/.oci stephenpearson/oci-cli:latest "$@"; }' >> ~/.profile
# reload ~/.profile
. ~/.profile

