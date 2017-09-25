
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

You can go to portal in your browser with this url - https://devenv-ag/

## Setting Up Mutual TLS for Firefox

* https://blog.codeship.com/how-to-set-up-mutual-tls-authentication/

# CA and certs generation

* https://jamielinux.com/docs/openssl-certificate-authority/create-the-root-pair.html

## Services Deployed in HTRC-DevEnvironment
| Service name | Access URL  | Deployed at  | Start Command inside the Dev-environment | Log file |
|---|---|---|---|---|
|wso2is - 5.3.0   | https://devenv-notls-is | /usr/share/wso2is  | sudo systemctl start wso2is | /usr/share/wso2is/repository/logs/wso2carbon.log |
|Registry Extension API   | | /usr/share/wso2is/repository/deployment/server/webapps/  | sudo systemctl start wso2is | /usr/share/wso2is/repository/logs/wso2carbon.log |
|Analytics Gateway| https://devenv-ag | /devenv_sources/Analytics-Gateway | sbt run (from the deploy folder) | /devenv_sources/Analytics-Gateway/logs/analytics-gateway.log |
| DC API, Agent, Email-Validator  | | /usr/share/tomcat   | sudo systemctl start tomcat | journalctl -u tomcat |

