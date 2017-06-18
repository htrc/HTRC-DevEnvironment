# Create the MySQL database
mysql --user=root  --password="y*MS2eb;&!&%p" < /devenv_sources/Analytics-Gateway/app/sql/token_manager_db_schema.sql

# Add HTRC CA cert to java keystore and WSO2 IS client-truststore.jks
keytool -import -trustcacerts -alias htrc-ca -file /devenv_sources/Analytics-Gateway/conf/HTRC-CA.crt -keystore /usr/java/jdk1.8.0_131/jre/lib/security/cacerts -storepass changeit
keytool -import -trustcacerts -alias htrc-ca -file /devenv_sources/Analytics-Gateway/conf/HTRC-CA.crt -keystore /usr/share/wso2is/repository/resources/security/client-truststore.jks -storepass wso2carbon
