#!/bin/sh

if [ -f "/opt/couchdb/data/_dbs.couch" ]; then
   echo "CouchDB Database already set up"
   exit 0
fi

if [ ! -d  "/opt/couchdb/data" ]; then
   echo "The /opt/couchdb/data directory is missing"
   exit 16
fi

tar -xvzf /ras_couchdb.tgz -C /opt/couchdb/data

chown -R 5984:5984 /opt/couchdb/data

echo "CouchDB Database populated"

