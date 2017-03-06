#!/bin/sh -eux

# Removing cloned data capsule source
rm -rf HTRC-DataCapsules

# Building Vagrant box
packer build -only=virtualbox-iso centos-7.3-x86_64.json
