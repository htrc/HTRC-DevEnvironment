#!/bin/sh -eux

# Set up to mount our certificates into the default CentOS certificate location
cat << EOF >> /etc/fstab
/devenv_certs   /etc/pki/CA none    defaults,bind   0   0
EOF

mount /etc/pki/CA
groupadd certs
chgrp -R certs /etc/pki/CA

# Install trusted CA certificates into the proper system location
cp /etc/pki/CA/certs/incommon_rsa.cert.pem /etc/pki/ca-trust/source/anchors/incommon_rsa.cert.pem
cp /etc/pki/CA/certs/ca.cert.pem /etc/pki/ca-trust/source/anchors/htrc-ca.cert.pem

# Update the system truststores (generates all certificates in /etc/pki/ca-trust/extracted)
update-ca-trust extract

# Update the Java default cacerts using the generated certs from the previous step
[ -f /etc/pki/ca-trust/extracted/java/cacerts ] && cp /etc/pki/ca-trust/extracted/java/cacerts /usr/java/latest/jre/lib/security/cacerts
