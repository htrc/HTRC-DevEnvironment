#!/bin/sh -eux

ln -s /etc/nginx/sites-available /etc/nginx/sites-enable
chmod -R vagrant:root /etc/nginx
