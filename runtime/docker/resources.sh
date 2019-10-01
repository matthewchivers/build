#!/bin/sh

docker run --name galasa-resources \
           --network galasa \
           --restart always \
           --detach         \
           --publish 8080:80 \
           galasa/galasa-resources-amd64:@dockerVersion@
           
