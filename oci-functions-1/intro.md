This scenario introduces serverless Functions on Oracle Cloud Infrastructure. The functions are created through Project Fn - using a local CLI. An application is created as a container for the function. The application is linked to a Subnet to provide network in which to run the function. The function is then deployed to OCI. Subsequently, you will invoke the function - in several ways:
* using Fn CLI
* using OCI CLI
* using Postman

You will use the OCI Console to verify the creation of application and function and to monitor the calls to the function and inspect the resulting log entries.

The scenario uses an Ubuntu 18.04 environment with Docker, OCI CLI and Fn CLI. Before you can start the steps in the scenario, the two Command Line interfaces are downloaded and installed. This will take about one minute. You will need Postman as well, if you want to invoke the Function directly from your computer.

The scenario works with Node (JS) as runtime language for the function. You can experiment with Java,Go, Ruby, Python as runtimes just as easily.
