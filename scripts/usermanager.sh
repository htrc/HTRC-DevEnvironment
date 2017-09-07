#!/bin/sh -eux

USERMANAGER_HOME=/opt/htrc-user-manager-2.1.0
unzip /devenv_downloads/htrc-user-manager-2.1.0.zip -d /opt
mkdir -p $USERMANAGER_HOME/log && chmod 777 $USERMANAGER_HOME/log

cat > /etc/profile.d/htrc-user-manager.sh << EOF
export USERMANAGER_HOME=$USERMANAGER_HOME
export PATH=$PATH:$USERMANAGER_HOME/bin
EOF

chmod +x /etc/profile.d/htrc-user-manager.sh