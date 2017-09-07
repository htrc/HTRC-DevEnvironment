
# HTRC-DevEnvironment

[Vagrant](https://www.vagrantup.com) based development environment for HTRC.

# Prerequisites

## VirtualBox

Install VirtualBox from [https://www.virtualbox.org](https://www.virtualbox.org).

## Vagrant

Please follow the [Vagrant installation guide](https://www.vagrantup.com/docs/installation/).

## Vagrant Host Manager

Vagrant::Hostmanager can be found [here](https://github.com/devopsgroup-io/vagrant-hostmanager). Install hostmanager plugin using the following command:

```
$ vagrant plugin install vagrant-hostmanager
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
You should have sudo access in the host. If you don't have sudo access, please add following line to sudoers file.
``<USERNAME>  ALL=(ALL)``

Run ```vagrant up``` to create an instance of HTRC development environment locally and use ```vagrant ssh``` to log into the VM.

## Setting Up Mutual TLS for Firefox

* https://blog.codeship.com/how-to-set-up-mutual-tls-authentication/


# CA and certs generation

* https://jamielinux.com/docs/openssl-certificate-authority/create-the-root-pair.html
