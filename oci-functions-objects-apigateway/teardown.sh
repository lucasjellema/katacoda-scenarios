#!/bin/bash

# remove function application from OCI environment 

fn delete f lab$LAB_ID hello --force
fn delete a lab$LAB_ID --force

touch /root/tearDownPerformed



