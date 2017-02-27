#!/bin/sh -eux

wget -P /usr/share/tomcat/webapps https://nexus.htrc.illinois.edu/content/repositories/snapshots/edu/indiana/d2i/sloan/sloan-ws/1.2-SNAPSHOT/sloan-ws-1.2-20170214.231705-1.war
systemctl enable tomcat
