
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

**Note: This plugin is required because VirtualBox guest additions get de-activated when kernel is updated before a restart of Vagrant VM.**

## Ansible

This Vagrant configuration uses [Ansible](https://www.ansible.com) provisioner. Please follow installation instructions for your host operating system from [here](http://docs.ansible.com/ansible/intro_installation.html).


# Configuration

```settings.yml``` can be used to customize synced directories and port forwarding.

# TODO

- Login to HTRC Docker registry during provisioning
- Service configurations specific to Vagrant development environment
- Tutorial on how to use the development environment
- Improve Ansible roles to work on Redhat based operating systems
- Convert Docker installation to a Ansible role
