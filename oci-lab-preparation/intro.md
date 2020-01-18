This scenario will guide you in preparing the OCI Lab Environment (for the OCI Katacoda scenarios) on any OCI tenancy.

The final environment will live in a single compartment called *lab-compartment*. This compartment also contains:
* an API Gateway
* a Stream
* a Dynamic Group 
* a VCN with subnets and an Internet Gateway

A user and a group are created. The user is a member of the group. Policies are created both granting privileges to the Dynamic Group and to the Group.

During the lab, the user will also create:
* an Application and multiple Functions
* a Bucket and multiple Files (Object Storage)
* an API Deployment (on the API Gateway) and multiple Routes

![The Lab Environment on OCI](/lucasjellema/scenarios/oci-lab-preparation/assets/oci-lab-environment.jpg)

