# Creating, Deploying and Invoking a Function on OCI

In this step we will create a simple function with Fn. We pick Node (JS) as our runtime - Go, Python, Java and Ruby are other out of the box options.

`fn init --runtime node hello`{{execute}}

`cd hello`{{execute}}

Three files have been created in the new directory *hello*.

`ls`{{execute}}

You could open func.js in the text editor to see the generated functionality. Feel free to edit the file - but please make sure it will execute correctly!

## Create Application

Set the environment variable LAB_ID to the number provided to you by the workshop instructor.

`export LAB_ID=1`{{execute}}

Note: Public Subnet-vcn-lab in compartment lab-compartment

`export SUBNET_OCID=ocid1.subnet.oc1.iad.aaaaaaaagfz4auw6rgkqbg4huwxno42cnuscafgvyivmdwl7lj6gabpktmvq`{{execute}}

Now create the new application that will be the container for your functions:

`fn create app "lab$LAB_ID" --annotation "oracle.com/oci/subnetIds=[\"$SUBNET_OCID\"]"`{{execute}}

See the list of applications - that should include your new application:

`fn list apps`{{execute}}

## Deploy the Function

Deploy the Function Hello, into an app that was created beforehand

`fn -v deploy --app "lab$LAB_ID"`{{execute}}

Verify that a Docker Container Image has been built for Fn Function Hello:

`docker images | grep hello`{{execute}}

Check the list of functions in the application
`fn list f "lab${LAB_ID}"`{{execute}}

Time to invoke the function. The command for invoking the function is simply: `fn invoke <app-name> <function-name>`:

`fn invoke "lab$LAB_ID" hello`{{execute}}

The first call may take a while because of the cold start of the function. If you call the function a second and third time, it is bound to go a lot quicker. 

To send in a JSON object as input to the function, use the following command:

`echo -n '{"name":"Your Own Name"}' | fn invoke "lab${LAB_ID}" hello --content-type application/json`{{execute}}

Again, a friendly, this time personalized welcome message should be your reward - coming from the cloud.

Check out details for the function you just created and deployed:
`fn inspect f "lab$LAB_ID" hello`{{execute}}

## OCI Console 

Check in the OCI Console if the function shows up there:

[OCI Console | Developer Services | Functions | Applications](https://console.us-ashburn-1.oraclecloud.com/functions)

Click on the application that you have just created to see the *hello* function.
