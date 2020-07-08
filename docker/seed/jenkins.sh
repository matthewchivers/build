#!/bin/sh

mkdir -p /var/jenkins_home

tar -xvzf jenkins-seed.tgz 
chown 1000:1000 /var/jenkins_home

sed -i "s/127.0.0.1:8082/$1:$2/g" /var/jenkins_home/jenkins.model.JenkinsLocationConfiguration.xml
sed -i "s/127.0.0.1:8080/$1:$3/g" /var/jenkins_home/dev.galasa.extensions.jenkins.plugin.GalasaConfiguration.xml

echo "Seed of Jenkins home is complete"