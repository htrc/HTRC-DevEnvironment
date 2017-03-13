#!/bin/sh -eux

unzip /devenv_downloads/wso2is-5.3.0.zip -d /usr/share
ln -s /usr/share/wso2is-5.3.0 /usr/share/wso2is

# Copying Registry Extension war to WSO2IS using gradle
cd /devenv_configurations/regx
/opt/gradle/latest/bin/gradle copyWar

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
