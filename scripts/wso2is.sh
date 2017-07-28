#!/bin/sh -eux

WSO2IS_HOME=/usr/share/wso2is
WSO2IS_CONF="$WSO2IS_HOME/repository/conf"
WSO2IS_CONF_SRC=/devenv_configurations/wso2is
WSO2IS_WEBAPPS="$WSO2IS_HOME/repository/deployment/server/webapps"
WSO2IS_AUTH_ENDPOINT="$WSO2IS_WEBAPPS/authenticationendpoint"
WSO2IS_AUTH_ENDPOINT_WAR="$WSO2IS_WEBAPPS/authenticationendpoint.war"

unzip /devenv_downloads/wso2is-5.3.0.zip -d /usr/share
ln -s /usr/share/wso2is-5.3.0 $WSO2IS_HOME

cp $WSO2IS_CONF_SRC/carbon.xml $WSO2IS_CONF/carbon.xml
cp $WSO2IS_CONF_SRC/claim-config.xml $WSO2IS_CONF/claim-config.xml
cp $WSO2IS_CONF_SRC/user-mgt.xml $WSO2IS_CONF/user-mgt.xml
cp $WSO2IS_CONF_SRC/output-event-adapters.xml $WSO2IS_CONF/output-event-adapters.xml
cp $WSO2IS_CONF_SRC/identity.xml $WSO2IS_CONF/identity/identity.xml
cp $WSO2IS_CONF_SRC/identity-mgt.properties $WSO2IS_CONF/identity/identity-mgt.properties
cp $WSO2IS_CONF_SRC/embedded-ldap.xml $WSO2IS_CONF/identity/embedded-ldap.xml
cp $WSO2IS_CONF_SRC/oidc-scope-config.xml $WSO2IS_CONF/identity/oidc-scope-config.xml
cp $WSO2IS_CONF_SRC/catalina-server.xml $WSO2IS_CONF/tomcat/catalina-server.xml
cp $WSO2IS_CONF_SRC/master-datasources.xml $WSO2IS_CONF/datasources/master-datasources.xml
cp $WSO2IS_CONF_SRC/wso2server.sh $WSO2IS_HOME/bin/wso2server.sh
cp $WSO2IS_CONF_SRC/mysql_connector_java_*.jar $WSO2IS_HOME/repository/components/dropins/

# Set up database for WSO2IS
mysql -u root -p'y*MS2eb;&!&%p' < $WSO2IS_CONF_SRC/wso2is.sql
mysql -u wso2 -p'zaq1!QAZxsw2@WSX' wso2is < $WSO2IS_HOME/dbscripts/mysql5.7.sql
mysql -u wso2 -p'zaq1!QAZxsw2@WSX' wso2is < $WSO2IS_HOME/dbscripts/identity/mysql-5.7.sql

# Copy customized web pages
mkdir -p $WSO2IS_AUTH_ENDPOINT
cd $WSO2IS_AUTH_ENDPOINT
unzip $WSO2IS_AUTH_ENDPOINT_WAR

cp $WSO2IS_CONF_SRC/login.jsp $WSO2IS_AUTH_ENDPOINT/login.jsp
cp $WSO2IS_CONF_SRC/logout.jsp $WSO2IS_AUTH_ENDPOINT/logout.jsp
cp $WSO2IS_CONF_SRC/basicauth.jsp $WSO2IS_AUTH_ENDPOINT/basicauth.jsp
cp $WSO2IS_CONF_SRC/is-htrc-theme.css $WSO2IS_AUTH_ENDPOINT/css/is-htrc-theme.css

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
