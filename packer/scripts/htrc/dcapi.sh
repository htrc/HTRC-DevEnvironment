#!/bin/sh -eux

# Copying DC API war to tomcat using gradle
cd /opt/dcapi

# Create the MySQL database
 mysql --user=root  --password=root -e "CREATE DATABASE IF NOT EXISTS `htrcvirtdb`;"
 mysql htrcvirtdb --user=root  --password=root < dc_schema.sql

# Copy the DC API to tomcapt webapps directory
gradle copyWar

# Deleting scripts used for provisioning
rm -r /opt/dcapi
