# Run and Explore GraalVM Docker Container

Get sources to work with in this scenario:
```
git clone https://github.com/AMIS-Services/graalvm-polyglot-meetup-november2019 
sudo chmod -R ugo+rw graalvm-polyglot-meetup-november2019
```{{execute}}

Run the GraalVM Container and map the sources directory into it:

`docker run -it -v /root/graalvm-polyglot-meetup-november2019:/labs oracle/graalvm-ce bash`{{execute}}

Check whether Java is installed and running as expected inside the container:

`java -version`{{execute}}

Type `node` to check the runtime version of node:
`node`{{execute}}

Type Ctrl+C twice, to end the Node session.

You can install the support for additional languages like Ruby, R, Python or WebAssembly at will. For example, the following command installs the Python, R and Ruby support :

```
gu install native-image
gu install python
gu install r
gu install ruby
```{{execute}}



