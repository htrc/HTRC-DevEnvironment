# Start WSO2 IS
systemctl start wso2is.service

# Start tomcat
systemctl start tomcat

# Start nginx
setsebool -P httpd_can_network_connect 1
systemctl start nginx

#systemctl start ag.service
