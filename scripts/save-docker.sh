#!/bin/sh

set -e

echo "Saving docker images"
docker save quay.io/coreos/etcd:v3.2.25 couchdb:2 galasa/galasa-ras-couchdb-init-amd64:0.3.0 galasa/galasa-master-api-amd64:0.3.0 galasa/galasa-boot-embedded-amd64:0.3.0 galasa/galasa-resources-amd64:0.3.0 | gzip > galasa-images.tar.gz

echo "Save complete"

