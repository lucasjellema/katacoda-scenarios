echo "Installing Project Fn - in the background"

export OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING=True


# add this line to ~/.profile - to make oci a recognized shell command
echo 'oci() { /root/bin/oci "$@"; }' >> ~/.profile
# reload ~/.profile
. /root/.profile
# now oci is recognized as a command


# prerequisite of OCI CLI
echo install python3-venv
sudo apt-get --yes --allow-downgrades --allow-remove-essential --allow-change-held-packages  install  python3-venv 


echo "Wait for the file /root/allSetInBackground to appear"


