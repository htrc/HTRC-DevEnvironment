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

## Ansible

This Vagrant configuration uses [Ansible](https://www.ansible.com) provisioner. Please follow installation instructions for your host operating system from [here](http://docs.ansible.com/ansible/intro_installation.html).

# Configuration

```settings.yml``` can be used customize synced directories and port forwarding.
