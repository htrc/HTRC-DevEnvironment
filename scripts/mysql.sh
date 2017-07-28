#!/bin/sh -eux

cp /devenv_configurations/mysql/my.cnf /etc/my.cnf
systemctl restart mysqld
