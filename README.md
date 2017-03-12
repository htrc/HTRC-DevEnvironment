
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

## vagrant-triggers

This plugin is used to perform some tasks before provisioning, after provisioning and after destroying the VM.

```
$ vagrant plugin install vagrant-triggers
```


# How To

Run ```vagrant up``` to create an instance of HTRC development environment locally and use ```vagrant ssh``` to log into the VM.


# CA and certs generation

* https://jamielinux.com/docs/openssl-certificate-authority/create-the-root-pair.html
