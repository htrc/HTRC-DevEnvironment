#!/bin/sh -eux

# Copy sites-available and nginx.conf from configurations
cp -r /devenv_configurations/nginx/sites-available /etc/nginx/
cp /devenv_configurations/nginx/nginx.conf /etc/nginx/

# Copy certs
mkdir /etc/nginx/certs
cp -r /devenv_certs/* /etc/nginx/certs

ln -s /etc/nginx/sites-available /etc/nginx/sites-enabled
chown -R vagrant:root /etc/nginx
