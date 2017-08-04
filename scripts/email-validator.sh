#!/bin/sh -eux

# Copying Email-Validator API war to tomcat using gradle
cd /devenv_configurations/email-validator

# Create the MySQL database
mysql --user=root  --password="y*MS2eb;&!&%p" < /devenv_sources/Email-Validator/sql/email_validator_db_schema.sql
mysql --user=root  --password="y*MS2eb;&!&%p" email_validator < /devenv_sources/Email-Validator/sql/email_validator_db_populator.sql


# Copy the Email-Validator API to tomcapt webapps directory
/opt/gradle/latest/bin/gradle copyWar

# Copy configuration files to /etc/htrc/email-validator
mkdir -p /etc/htrc/email-validator
cp default.properties /etc/htrc/email-validator
