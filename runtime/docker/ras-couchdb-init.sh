#!/bin/sh

docker run --name galasa-couchdb-init \
           --network galasa \
           --mount source=galasa-couchdb,target=/opt/couchdb/data \
           galasa/galasa-ras-couchdb-init-amd64:@dockerVersion@
           