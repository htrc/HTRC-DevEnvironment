# HTRC Development Environment Image Builder

Set of configurations and provisioning scripts for [Packer](https://www.packer.io) based development environment image creation.

** Note: These templates are based on [bento](http://chef.github.io/bento/) project.**

# How To Build CentOS 7.3 Box

```
$ packer build -only=virtualbox-iso centos-7.3=x86_64.json
```
