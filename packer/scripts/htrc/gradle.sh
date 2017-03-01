#!/bin/sh -eux

downloadLatestVersion ()
{
  echo "Downloading new version of gradle..."
  sleep 5s
  wget -cN http://services.gradle.org/distributions/gradle-${gradle_version}-all.zip
  echo "Extracting zip file..."
  sleep 5s
  unzip -od /opt/gradle gradle-${gradle_version}-all.zip
  echo "Creating symbolic link..."
  sleep 5s
  ln -sfn gradle-${gradle_version} /opt/gradle/latest
  echo "Setting up environment variables..."
  printf "export GRADLE_HOME=/opt/gradle/latest\nexport PATH=\$PATH:\$GRADLE_HOME/bin\nexport GRADLE_INSTALLED_VERSION='${gradle_version}'" > gradle.sh
  chmod +x gradle.sh
  mv gradle.sh /etc/profile.d/
  . /etc/profile.d/gradle.sh
  echo "Gradle installation done!!!"
}

gradle_service_url='http://services.gradle.org/versions/current'
echo "Fetching latest version number..."
gradle_version=$(echo $(wget -O - -q -t 1 $gradle_service_url) | grep version | awk '{ print $2 }' | sed s/\"//g | sed s/,//g | sed s/version://g)
echo "Current gradle version is:" $gradle_version

downloadLatestVersion
