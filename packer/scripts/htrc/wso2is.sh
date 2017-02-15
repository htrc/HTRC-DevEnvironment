#!/bin/sh -eux

wget -P /tmp/ http://analytics.hathitrust.org/files/wso2is-${WSO2IS_VERSION}.zip
unzip /tmp/wso2is-${WSO2IS_VERSION}.zip -d /usr/share
ln -s /usr/share/wso2is-${WSO2IS_VERSION} /usr/share/wso2is
