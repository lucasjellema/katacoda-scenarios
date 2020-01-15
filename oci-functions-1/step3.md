# Create, Deploy and Invoke Node Application as FileWriter Function on OCI

In this step, you wrap the FileWriter application in a Function and deploy that function on OCI. Then we will invoke the function.

Check the contents of file `~/oracle-cloud-native-meetup-20-january-2020/functions/file-writer/func.js`. This file is the wrapper for the Fn Function around the FileWriter application.

`cat ~/oracle-cloud-native-meetup-20-january-2020/functions/file-writer/func.js`{{execute}}

Let's deploy this function to application `lab#`. Execute the next command - make sure you are in the correct directory.

```
cd ~/oracle-cloud-native-meetup-20-january-2020/functions/file-writer`{{execute}}
fn -v deploy --app "lab$LAB_ID"
```{{execute}}


