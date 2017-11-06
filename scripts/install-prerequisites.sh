#!/bin/sh -eux
yum -y install wget
cd /tmp

wget -nc -P /tmp/ --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm"

yum -y install /tmp/jdk-8u131-linux-x64.rpm

rm /tmp/jdk-8u131-linux-x64.rpm

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
mysql  -h localhost -u root -p'y*MS2eb;&!&%p' -e 'exit' 2>/dev/null || mysqladmin -u root --password=${oldpass} password $newpass

# Install sbt, NodeJS and npm packages

echo 'Installing sbt'
curl https://bintray.com/sbt/rpm/rpm | sudo tee /etc/yum.repos.d/bintray-sbt-rpm.repo
yum -y install sbt bc

echo 'Installing NodeJS'
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
yum -y install nodejs
yum -y install gcc-c++ make

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
yum -y install libffi-devel
yum -y install python-cffi

pip install httpie

systemctl daemon-reload
systemctl enable tomcat
systemctl enable mysqld
systemctl enable nginx

# For getting /usr/sbin/semanage
yum -y install policycoreutils-python

# To get vimdiff
yum -y install vim-enhanced

# Configure global logging for tomcat web apps
cp /devenv_configurations/tomcat/tomcat.conf /etc/tomcat
cp /devenv_configurations/tomcat/logback.xml /etc/tomcat

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
