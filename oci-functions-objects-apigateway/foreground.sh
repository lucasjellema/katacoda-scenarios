echo "Installing Project Fn - in the background"

export OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING=True

# add this line to ~/.profile - to make oci a recognized shell command
echo 'oci() { /root/bin/oci "$@"; }' >> ~/.profile
# reload ~/.profile
. /root/.profile
# now oci is recognized as a command

# get workshop resource into scenario

git clone https://github.com/AMIS-Services/oracle-cloud-native-meetup-20-january-2020

echo "Wait for the file /root/allSetInBackground to appear"


