#!/bin/sh

set -e
set -x

./pull-docker-ibm.sh
./retag-docker.sh

docker run -d --name zip galasa/galasa-resources-amd64:0.3.0
rm -rf temp
mkdir -p temp/galasa
docker cp zip:/usr/local/apache2/htdocs/eclipse temp/galasa/
docker cp zip:/usr/local/apache2/htdocs/javadoc temp/galasa/
docker cp zip:/usr/local/apache2/htdocs/maven temp/galasa/
docker cp zip:/usr/local/apache2/htdocs/testcatalogs temp/galasa/
cd temp
zip -r galasa.zip galasa
cd ..
docker rm -f zip
