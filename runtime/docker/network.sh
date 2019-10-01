#!/bin/sh

docker network create \
               --driver=bridge \
               --subnet=172.21.0.0/16 \
               --gateway=172.21.0.1 \
               galasa