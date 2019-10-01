#!/bin/sh

docker run --name galasa \
           --network galasa \
           --restart always \
           --detach \
           --publish 2080:2080 \
           --publish 2023:2023 \
           galasa/galasa-boot-embedded-amd64:@dockerVersion@ \
           java -jar simframe.jar
           
