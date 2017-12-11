# Create the MySQL database
mysql --user=root  --password="y*MS2eb;&!&%p" < /devenv_sources/Analytics-Gateway/app/sql/token_manager_db_schema.sql

# Add HTRC CA cert to java keystore and WSO2 IS client-truststore.jks
keytool -import -trustcacerts -alias htrc-ca -file /devenv_certs/certs/ca.cert.pem -keystore /usr/java/latest/jre/lib/security/cacerts -storepass changeit -noprompt
keytool -import -trustcacerts -alias htrc-ca -file /devenv_certs/certs/ca.cert.pem -keystore /usr/share/wso2is/repository/resources/security/client-truststore.jks -storepass wso2carbon -noprompt

# Generate the distribution
cd /devenv_sources/Analytics-Gateway/
npm install webpack -g
npm install webpack
npm install
cp -r /devenv_sources/HTRC-DevOps/configuration/vagrant-dev-env/ag/conf ./
# sbt dist
#
# cd /usr/share/
# unzip /devenv_sources/Analytics-Gateway/target/universal/htrc-analytics-gateway-*.zip
# mv htrc-analytics-gateway-* ag
# rm -r /usr/share/ag/conf
# cp -r /devenv_sources/HTRC-DevOps/configuration/vagrant-dev-env/ag/conf /usr/share/ag/
#
# cat > /etc/systemd/system/ag.service <<EOF
# [Unit]
# Description=HTRC Analytics Server service
# Wants=syslog.target network.target
# After=syslog.target network.target mysqld.service
#
# [Service]
# WorkingDirectory=/usr/share/ag
# RestartForceExitStatus=121
# ExecStart=/usr/share/ag/bin/htrc-analytics-gateway
#
# [Install]
# WantedBy=multi-user.target
# EOF
#
# systemctl daemon-reload
# systemctl enable ag.service
