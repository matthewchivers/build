#!/bin/bash

mvn -f "/Users/matthewchivers/Galasa/build/eclipse/dev.galasa.eclipse.site" clean install
mvn -f "/Users/matthewchivers/Galasa/build/docker/eclipse" clean install