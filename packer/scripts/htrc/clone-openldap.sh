#!/bin/sh -eux

if [ ! -d openLDAP ]; then
  mkdir -p openLDAP
else
  rm -r openLDAP
  mkdir -p openLDAP
fi
git clone https://github.com/htrc/openLDAP.git
