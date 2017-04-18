#!/bin/sh -eux

unzip /devenv_downloads/wso2is-5.3.0.zip -d /usr/share
ln -s /usr/share/wso2is-5.3.0 /usr/share/wso2is

cp /devenv_configurations/wso2is/carbon.xml /usr/share/wso2is/repository/conf/carbon.xml
cp /devenv_configurations/wso2is/claim-config.xml /usr/share/wso2is/repository/conf/claim-config.xml
cp /devenv_configurations/wso2is/user-mgt.xml /usr/share/wso2is/repository/conf/user-mgt.xml
cp /devenv_configurations/wso2is/output-event-adapters.xml /usr/share/wso2is/repository/conf/output-event-adapters.xml
cp /devenv_configurations/wso2is/identity.xml /usr/share/wso2is/repository/conf/identity/identity.xml
cp /devenv_configurations/wso2is/embedded-ldap.xml /usr/share/wso2is/repository/conf/identity/embedded-ldap.xml
cp /devenv_configurations/wso2is/oidc-scope-config.xml /usr/share/wso2is/repository/conf/identity/oidc-scope-config.xml
cp /devenv_configurations/wso2is/catalina-server.xml /usr/share/wso2is/repository/conf/tomcat/catalina-server.xml


# Copying Registry Extension war to WSO2IS using gradle
cd /devenv_configurations/regex
/opt/gradle/latest/bin/gradle copyWar

# Copy configuration files to /etc/htrc/regx
mkdir -p /etc/htrc/regex
cp jwtfilter.conf /etc/htrc/regex

cat > /etc/default/wso2is <<EOF
JAVA_HOME=/usr/java/default
CARBON_HOME=/usr/share/wso2is
EOF

cat > /etc/systemd/system/wso2is.service <<EOF
[Unit]
Description=WSO2 Identity Server service
Wants=syslog.target network.target
After=syslog.target network.target

[Service]
WorkingDirectory=/usr/share/wso2is
EnvironmentFile=-/etc/default/wso2is
RestartForceExitStatus=121
ExecStart=/usr/share/wso2is/bin/wso2server.sh

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable wso2is.service
systemctl start wso2is.service
