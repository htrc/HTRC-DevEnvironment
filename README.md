
# HTRC-DevEnvironment

[Vagrant](https://www.vagrantup.com) based development environment for HTRC.

# Prerequisites

## Vagrant

Please follow the [Vagrant installation guide](https://www.vagrantup.com/docs/installation/).

## Vagrant Host Updater

Vagrant::Hostupdater can be found [here](vagrant host updater). Install hostupdater using following command:

```
$ vagrant plugin install vagrant-hostsupdater
```

## vagrant-vbguest plugin

This plugin automatically installs the host's VirtualBox Guest Additions on the guest system if guest additions are not present in the guest system. Install the plugin using following command:

```
$ vagrant plugin install vagrant-vbguest
```

**Note: This plugin is required because VirtualBox guest additions get de-activated when kernel is updated before a restart of the Vagrant VM.**

## Ansible

This Vagrant configuration uses [Ansible](https://www.ansible.com) provisioner. Please follow installation instructions for your host operating system from [here](http://docs.ansible.com/ansible/intro_installation.html).


# How To

First clone the repository using following command to include submodules. Configurations for the local development environment is coming from HTRC-Configuration project's 'local' branch. We have added it as a git submodule to this repository.

```
$ git clone --recursive https://github.com/htrc/HTRC-DevEnvironment.git
```

Then you can run ```vagrant up``` to create an instance of HTRC development environment locally and use ```vagrant ssh``` to log into the VM.

We have created a Docker Compose script which runs IDP and Portal with required dependencies and you can find it at ```/vagrant/HTRC-Configuration/docker/idp+portal``` directory within the VM. Running ```docker-compose up``` while you in ```idp+portal``` directory will spawn Portal and IDP instances and setup Nginx to serve Portal and IDP via ```htrc-devenv``` domain from the Vagrant host (We use Vagrant host-updater plugin to configure hostnames in your machine). HTRC Portal will be available at [https://htrc-devenv:1143](https://htrc-devenv:1143) and IDP will be available at [https://htrc-devenv:1043](https://htrc-devenv:1043).

# Configuration

```settings.yml``` can be used to customize synced directories and port forwarding.

# Notes

* Docker Hub is used to host Docker images
* Current version uses Ubuntu as VM operating system due to an issue with CentOS and Vagrant integration.

# TODO

- Get CentOS based development environment working.

# CA and certs generation - https://jamielinux.com/docs/openssl-certificate-authority/create-the-root-pair.html

# Building and registering vagrant box
`cd packer`
`packer build -only=virtualbox-iso centos-7.3-x86_64.json`
`vagrant box add htrc/devenv builds/centos-7.3.virtualbox.box`
`cd ..`
`vagrant init htrc/devenv`
`vagrant up`

`vagrant destroy`
