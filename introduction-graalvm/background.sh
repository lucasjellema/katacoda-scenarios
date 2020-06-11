#!/bin/bash

# install Project Fn CLI
curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh

touch /root/downloadedFnCLI

docker pull fnproject/fnserver:latest

touch /root/pulledFnServerImage

fn start &

touch /root/startedFnServer

docker pull fnproject/node:latest

touch /root/readyWithBackground
