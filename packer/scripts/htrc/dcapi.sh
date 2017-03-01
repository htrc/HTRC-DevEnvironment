#!/bin/sh -eux

# Copying DC API war to tomcat using gradle
cd /opt/dcapi
gradle copyWar
cd
rm -r /opt/dcapi
