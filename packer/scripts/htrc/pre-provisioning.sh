#!/bin/sh -eux

sudo mkdir -p /etc/nginx/certs
chown vagrant /etc/nginx/certs

sudo mkdir -p /etc/htrc/configurations
chown -R vagrant /etc/htrc
