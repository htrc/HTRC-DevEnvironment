#!/bin/sh -eux

# Copying DC API war to tomcat using gradle
cd /devenv_configurations/dcapi

# Create the MySQL database
mysql --user=root  --password="y*MS2eb;&!&%p" < /devenv_sources/HTRC-DataCapsules/webservice/src/main/resources/dc_schema.sql
mysql --user=root  --password="y*MS2eb;&!&%p" < /devenv_sources/HTRC-DataCapsules/webservice/src/main/resources/loaddata.sql


# Copy the DC API to tomcapt webapps directory
/opt/gradle/latest/bin/gradle copyWar

# Copy configuration files to /etc/htrc/dcapi
mkdir -p /etc/htrc/dcapi
cp sites.xml /etc/htrc/dcapi
cp log4j.properties /etc/htrc/dcapi
cp jwtfilter.conf /etc/htrc/dcapi

# Create the log file location
mkdir -p /var/log/htrc/dcapi
