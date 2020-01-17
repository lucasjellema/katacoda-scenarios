#!/bin/bash

# pull fn images for Java JDK (for build) and Runtime
docker pull fnproject/fn-java-fdk-build:jdk11-1.0.104
docker pull fnproject/fn-java-fdk:jre11-1.0.104
touch /root/createdFromSTep4BackgroundScript