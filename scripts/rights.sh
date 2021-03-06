#!/bin/sh -eux

# Copying RIGHTS war to tomcat using gradle
cd /devenv_configurations/rights

# Copy the RIGHTS war to tomcapt webapps directory
/opt/gradle/latest/bin/gradle copyWar

# Copy configuration files to /etc/htrc/rights
mkdir -p /etc/htrc/rights
cp jwtfilter.conf /etc/htrc/rights

# Create data folder
mkdir -p /var/lib/htrc/rights
cp /devenv_data/rights/vol-ids-level12.txt /var/lib/htrc/rights
