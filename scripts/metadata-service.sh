#!/bin/sh -eux
ls -l /
ls -l /devenv_sources
cd /devenv_sources/HTRC-MetadataService

cat << EOF > start.sh
#!/bin/sh
export METASERVICE_SECRET="k5@k3G@u8qh>dOJUIRypOyzgKHA;oXZ^ShBLny8s;w7pvwvalBR8Q]<gNENrrVWB"
./target/universal/stage/bin/htrc-metadata-service -Dhttp.address=localhost -Dhttp.port=8083 -Dplay.http.context=/api
EOF

chmod +x start.sh

sbt stage && tmux new -d -c /devenv_sources/HTRC-MetadataService -n start -s metadata-service ./start.sh \; detach
