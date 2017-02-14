#!/bin/sh -eux

cd /tmp

 wget -P /tmp/ --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm"

 yum -y install /tmp/jdk-8u121-linux-x64.rpm

 rm /tmp/jdk-8u121-linux-x64.rpm

wget -P /tmp/ https://repo.mysql.com//mysql57-community-release-el7-9.noarch.rpm

rpm -ivh /tmp/mysql57-community-release-el7-9.noarch.rpm

rm /tmp/mysql57-community-release-el7-9.noarch.rpm

yum -y install mysql-server

yum -y install epel-release
yum -y install redis
yum -y install tomcat
yum -y install nginx
