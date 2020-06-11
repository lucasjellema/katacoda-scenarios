In this step, we will together prepare the environment for working with GraalVM. We will use the GraalVM Community Edition Docker Container Image.

`GITHUB_PACKAGE_SERVER_TOKEN="17b0afa58628ded4f5e59c4db630bc647ccbbd43"`{{execute}}

Log in to the GitHub Package Server with the Docker Client:

`docker login https://docker.pkg.github.com -u lucasjellema --password $GITHUB_PACKAGE_SERVER_TOKEN`{{execute}}

Pull the GraalVM Community Edition Docker Container Image:
`docker pull docker.pkg.github.com/graalvm/container/community:latest`{{execute}}

List the image(s):

`docker images`{{execute}}