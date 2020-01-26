echo "Installing OCI CLI - in the background"

export OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING=True

# add this line to ~/.profile - to make oci a recognized shell command
echo 'oci() { /root/bin/oci "$@"; }' >> ~/.profile
# reload ~/.profile
. /root/.profile
# now oci is recognized as a command

echo "Wait for the file /root/readyWithBackground to appear"


