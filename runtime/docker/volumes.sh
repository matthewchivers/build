#!/bin/sh

set -e

docker volume create galasa-etcd
docker volume create galasa-couchdb
docker volume create galasa-api