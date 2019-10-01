#!/bin/sh

docker run --detach \
           --name galasa-cps \
           --network galasa \
           --restart always \
           --mount source=galasa-etcd,target=/var/run/etcd/default.etcd \
           --publish 2379:2379 \
           quay.io/coreos/etcd:v3.2.25 \
           etcd --data-dir /var/run/etcd/default.etcd --initial-cluster default=http://127.0.0.1:2380 --listen-client-urls http://0.0.0.0:2379 --listen-peer-urls http://0.0.0.0:2380 --initial-advertise-peer-urls http://127.0.0.1:2380 --advertise-client-urls http://127.0.0.1:2379
           