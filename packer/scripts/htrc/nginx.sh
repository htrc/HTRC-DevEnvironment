#!/bin/sh -eux

ln -s /etc/nginx/sites-available /etc/nginx/sites-enable
chown -R vagrant:root /etc/nginx
