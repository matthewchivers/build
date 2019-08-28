#!/bin/sh

set -e

echo "Tagging couchdb init"
docker tag cicsts-docker-local.artifactory.swg-devops.com/galasa-ras-couchdb-init-amd64:0.3.0 galasa/galasa-ras-couchdb-init-amd64:0.3.0

echo "Tagging api master server"
docker tag cicsts-docker-local.artifactory.swg-devops.com/galasa-master-api-amd64:0.3.0 galasa/galasa-master-api-amd64:0.3.0

echo "Tagging boot"
docker tag cicsts-docker-local.artifactory.swg-devops.com/galasa-boot-embedded-amd64:0.3.0 galasa/galasa-boot-embedded-amd64:0.3.0

echo "Tagging resources"
docker tag cicsts-docker-local.artifactory.swg-devops.com/galasa-resources-amd64:0.3.0 galasa/galasa-resources-amd64:0.3.0

echo "Tagging complete"

