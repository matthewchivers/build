#!/bin/sh

set -e

echo "Pulling etcd"
docker pull quay.io/coreos/etcd:v3.2.25
           
echo "Pulling couchdb"
docker pull couchdb:2

echo "Pulling couchdb init"
docker pull galasa/galasa-ras-couchdb-init-amd64:@dockerVersion@

echo "Pulling api master server"
docker pull galasa/galasa-api-bootstrap-amd64:@dockerVersion@

echo "Pulling boot"
docker pull galasa/galasa-boot-embedded:@dockerVersion@

echo "Pulling resources"
docker pull galasa/galasa-resources:@dockerVersion@

echo "Pulling complete"