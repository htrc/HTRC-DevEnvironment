#!/bin/sh -eux

mkdir -p /etc/nginx/certs
chown vagrant /etc/nginx/certs

mkdir -p /etc/nginx/sites-available
chown vagrant -R /etc/nginx

mkdir -p /etc/htrc/configurations
chown -R vagrant /etc/htrc

mkdir -p /opt/dcapi
mkdir -p /opt/regx
