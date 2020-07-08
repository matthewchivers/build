#!/bin/sh

mkdir -p /nexus-data

tar -xvzf nexus-seed.tgz 
chown 200:200 /nexus-data

echo "Seed of Nexus database is complete"