#!/bin/sh -eux

# Copying DC API war to tomcat using gradle
cd /devenv_configurations/dcapi

# Create the MySQL database
mysql --user=root  --password="y*MS2eb;&!&%p" < /devenv_sources/HTRC-DataCapsules/webservice/src/main/resources/dc_schema.sql

# Copy the DC API to tomcapt webapps directory
/opt/gradle/latest/bin/gradle copyWar

# Copy sites.xml file to /etc/htrc/dcapi
mkdir -p /etc/htrc/dcapi
cp sites.xml /etc/htrc/dcapi
