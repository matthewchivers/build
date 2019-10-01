#!/bin/sh

docker run --name galasa-controller \
           --network galasa \
           --restart always \
           --detach \
           -v $(pwd)/controller.properties:/controller.properties \
           -e CONFIG=file:/controller.properties \
           galasa/galasa-boot-embedded-amd64:@dockerVersion@ \
           java -jar boot.jar --obr file:galasa.obr --dockercontroller --bootstrap http://galasa-api:8181/bootstrap
           
