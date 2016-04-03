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

Following Ansible roles are used in the provisioning script and those roles can be installed using ```ansible-galaxy```.

### [ansiblebit.oracle-java](https://galaxy.ansible.com/detail#/role/3375)

```
$ sudo ansible-galaxy install ansiblebit.oracle-java
```

### [milinda.sbt](https://galaxy.ansible.com/milinda/sbt/)

```
$ sudo ansible-galaxy install milinda.sbt
```

### [tecris.maven](https://galaxy.ansible.com/tecris/maven/)

```
$ sudo ansible-galaxy install tecris.maven
```


# Configuration

```settings.yml``` can be used to customize synced directories and port forwarding.

# TODO

- Login to HTRC Docker registry during provisioning
- Service configurations specific to Vagrant development environment
- Tutorial on how to use the development environment
