#!/bin/sh

docker run --name galasa-resmon \
           --network galasa \
           --restart always \
           --detach \
           galasa/galasa-boot-embedded-amd64:@dockerVersion@ \
           java -jar boot.jar --obr file:galasa.obr --resourcemanagement --bootstrap http://galasa-api:8181/bootstrap
           
