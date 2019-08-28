#!/bin/sh

set -e

echo "Pulling etcd"
docker pull quay.io/coreos/etcd:v3.2.25
           
echo "Pulling couchdb"
docker pull couchdb:2

echo "Pulling couchdb init"
docker pull cicsts-docker-local.artifactory.swg-devops.com/galasa-ras-couchdb-init-amd64:0.3.0

echo "Pulling api master server"
docker pull cicsts-docker-local.artifactory.swg-devops.com/galasa-master-api-amd64:0.3.0

echo "Pulling boot"
docker pull cicsts-docker-local.artifactory.swg-devops.com/galasa-boot-embedded-amd64:0.3.0

echo "Pulling resources"
docker pull cicsts-docker-local.artifactory.swg-devops.com/galasa-resources-amd64:0.3.0

echo "Pulling complete"

