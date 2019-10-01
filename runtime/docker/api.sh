#!/bin/sh

docker run --name galasa-api \
           --network galasa \
           --restart always \
           --detach         \
           -v $(pwd)/bootstrap.properties:/galasa/etc/dev.galasa.cfg \
           --mount source=galasa-api,target=/galasa/data/galasa \
           --publish 8181:8181 \
           --publish 127.0.0.1:8101:8101 \
           galasa/galasa-master-api-amd64:@dockerVersion@ \
           /galasa/bin/karaf server
           