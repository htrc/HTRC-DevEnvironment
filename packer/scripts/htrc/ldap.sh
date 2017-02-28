#!/bin/sh -eux

## inital host prep/setup
cd /home/vagrant/openLDAP

# some helpful ldap aliases
# searching, passwords, adds, etc
source bin/aliases.sh

# install initial python requirements (if not provisioned)
cd bin
./ldap-prime --install-requirements


# make sure required directory is there for certs
mkdir /etc/openldap/cacerts
chown ldap:ldap  /etc/openldap/cacerts

# prime a host for ldap
./ldap-prime

# deploy from the cloned repo - you have to sudo it the first time.
# ldap-prime does some odd things to the git local workspace permissions
# you may need to fix these.
fab pack
fab test deploy

# note: had to add this to /etc/syslog.conf and restart syslog:
# to entable logging
local4.* /var/log/slapd.log
# and touch /var/log/slapd.log for logging to startup.

# clean up from prime
chown  vagrant:vagrant /home/vagrant/openLDAP


# once you have a master LDAP up and running on a host, you can initialize it
# using:
cp schema/init*.ldif /tmp/
/sbin/service masterldap slapadd /tmp/init-objectclasses.ldif
/sbin/service masterldap slapadd /tmp/init-entries.ldif
/sbin/service masterldap slapadd /tmp/init-users-add.ldif
rm /tmp/init*.ldif

# crontab entry for daily backups of the masterldap - this is the only one you really need to back up
# since	  replicas can just be rebuilt from the master via replication
45 02,08,14,20 * * * /var/htrcLDAP/ldapconf/production/bin/backup-ldap -k 7 -o /var/htrcLDAP/LDAPBackup -f /var/htrcLDAP/ldapconf/production/conf/slapd-master.conf


# conf has all the config include:
#      acls
#      berkley storage and indexing
#      ldap config files for master and replicas (DEV,TEST,PROD)
