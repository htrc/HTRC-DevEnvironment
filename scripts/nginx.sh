#!/bin/sh -eux

# Copy sites-available and nginx.conf from configurations
cp -R /devenv_configurations/nginx/sites-available /etc/nginx/
cp /devenv_configurations/nginx/nginx.conf /etc/nginx/

mkdir /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/idp.conf /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/email.conf /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/registry.conf /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/ag.conf /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/metadata.conf /etc/nginx/sites-enabled
chown -R vagrant:root /etc/nginx

# Give NGINX access to certificates in /etc/pki/CA
usermod -a -G certs nginx
