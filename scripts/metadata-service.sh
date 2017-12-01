#!/bin/sh -eux
cd /devenv_sources/HTRC-MetadataService

cat << EOF > start.sh
#!/bin/sh
export METASERVICE_SECRET="k5@k3G@u8qh>dOJUIRypOyzgKHA;oXZ^ShBLny8s;w7pvwvalBR8Q]<gNENrrVWB"
/devenv_sources/HTRC-MetadataService/target/universal/stage/bin/htrc-metadataservice -Dhttp.address=localhost -Dhttp.port=8083 -Dplay.http.context=/api
EOF

chmod +x start.sh
sbt stage

# Set up the systemd service
cat << EOF > /etc/systemd/system/metadata.service
[Unit]
Description=HTRC Metadata Service
Wants=syslog.target network.target
After=syslog.target network.target mongod.service

[Service]
WorkingDirectory=/devenv_sources/HTRC-MetadataService
ExecStart=/devenv_sources/HTRC-MetadataService/start.sh

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable metadata.service --now
