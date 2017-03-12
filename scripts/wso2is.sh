#!/bin/sh -eux

wget -P /tmp/ http://analytics.hathitrust.org/files/wso2is-${WSO2IS_VERSION}.zip
unzip /tmp/wso2is-${WSO2IS_VERSION}.zip -d /usr/share
ln -s /usr/share/wso2is-${WSO2IS_VERSION} /usr/share/wso2is

# Copying Registry Extension API to WSO2IS using gradle
cd /opt/regx
/opt/gradle/latest/bin/gradle copyWar
cd
rm -r /opt/regx

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
