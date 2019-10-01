#!/bin/sh

docker run --name galasa-ras \
           --network galasa \
           --restart always \
           --detach \
           --env-file galasa-env.properties \
           --mount source=galasa-couchdb,target=/opt/couchdb/data \
           --publish 5984:5984 \
           couchdb:2
           