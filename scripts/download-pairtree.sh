#!/bin/sh -eux

# Download sample pairtree
mkdir -p /var/lib/htrc/pairtree
wget -O /var/lib/htrc/pairtree/pairtree.zip https://analytics.hathitrust.org/files/pairtree.zip
cd /var/lib/htrc/pairtree
unzip pairtree.zip
rm -f pairtree.zip
wget -O /var/lib/htrc/pairtree/level1-volumes-110.csv https://analytics.hathitrust.org/files/level1-volumes-110.csv
