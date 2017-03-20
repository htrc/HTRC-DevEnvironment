#!/bin/sh -eux

# Copying AGENT war to tomcat using gradle
cd /devenv_configurations/agent

# Copy the AGENT to tomcapt webapps directory
/opt/gradle/latest/bin/gradle copyWar

# Copy configuration files to /etc/htrc/agent
mkdir -p /etc/htrc/agent
cp htrc.conf /etc/htrc/agent
cp jwtfilter.conf /etc/htrc/agent

# Create the log file location
mkdir -p /var/log/htrc/agent

# Create job_results folder
mkdir -p /var/lib/htrc/agent
cp -r /devenv_data/agent/agent_job_results /var/lib/htrc/agent
