# HTRC Development Environment Image Builder

Set of configurations and provisioning scripts for [Packer](https://www.packer.io) based development environment image creation.

** Note: These templates are based on [bento](http://chef.github.io/bento/) project.**

# How To Build CentOS 7.3 Box

```
$ packer build -only=virtualbox-iso centos-7.3=x86_64.json
```

# Addign OpenLDAP

There are some unresolved issues in LDAP provisioning scripts. So we are postponing support for OpenLDAP until those issues are resolved. When the issues are fixed, use following provisioning blocks to clode openLDAP repo and copy it to VM.

```
{
  "type": "shell-local",
  "command": "sh ./scripts/htrc/clone-openldap.sh"
},
{
  "type": "file",
  "source": "openLDAP",
  "destination": "/home/vagrant"
}
```
