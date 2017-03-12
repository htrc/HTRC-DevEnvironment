#!/bin/sh -eux

# Copying DC API war to tomcat using gradle
cd /opt/dcapi

# Create the MySQL database
mysql --user=root  --password="y*MS2eb;&!&%p" < dc_schema.sql

# Copy the DC API to tomcapt webapps directory
/opt/gradle/latest/bin/gradle copyWar

# Deleting scripts used for provisioning
rm -r /opt/dcapi