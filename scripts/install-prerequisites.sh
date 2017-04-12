#!/bin/sh -eux
yum -y install wget
cd /tmp

wget -nc -P /tmp/ --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm"

yum -y install /tmp/jdk-8u121-linux-x64.rpm

rm /tmp/jdk-8u121-linux-x64.rpm

wget -nc -P /tmp/ https://repo.mysql.com//mysql57-community-release-el7-9.noarch.rpm

rpm -ivh /tmp/mysql57-community-release-el7-9.noarch.rpm

rm /tmp/mysql57-community-release-el7-9.noarch.rpm

yum -y install mysql-server

systemctl daemon-reload
systemctl enable mysqld
systemctl start mysqld

systemctl status mysqld.service

echo 'Finally the root password needed for mysql to start'
echo 'oldpass will contain the temporary password value'
echo 'newpass must be written here and must meet Mysql Password Policies'
oldpass=$( grep 'temporary.*root@localhost' /var/log/mysqld.log |
        tail -n 1 |  sed 's/.*root@localhost: //' )
newpass="y*MS2eb;&!&%p"
mysqladmin -u root --password=${oldpass} password $newpass

yum -y install epel-release
yum -y install redis
yum -y install tomcat
yum -y install nginx
yum -y install unzip
yum -y install zip
yum -y install openldap-servers openldap-clients
yum -y install python-setuptools
yum -y install python-devel
easy_install pip
yum -y install mlocate
yum -y install openssl-devel
yum -y install openssl-perl

systemctl daemon-reload
systemctl enable tomcat
systemctl enable mysqld
systemctl enable nginx

updatedb


downloadLatestVersion ()
{
  sleep 5s
  wget -cN http://services.gradle.org/distributions/gradle-3.4.1-all.zip
  sleep 5s
  unzip -od /opt/gradle gradle-3.4.1-all.zip
  sleep 5s
  ln -sfn gradle-3.4.1 /opt/gradle/latest
  printf "export GRADLE_HOME=/opt/gradle/latest\nexport PATH=\$PATH:\$GRADLE_HOME/bin\nexport GRADLE_INSTALLED_VERSION='3.4.1'" > gradle.sh
  chmod +x gradle.sh
  mv gradle.sh /etc/profile.d/
  . /etc/profile.d/gradle.sh
}

downloadLatestVersion

yum -y install ntp
chkconfig ntpd on
ntpdate pool.ntp.org
systemctl start ntpd.service
timedatectl set-timezone America/Indiana/Indianapolis
timedatectl set-ntp yes
