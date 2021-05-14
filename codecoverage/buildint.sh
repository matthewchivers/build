#!/bin/bash

set -e
mkdir -p target/image/integrated

java -jar target/org.jacoco.cli.jar merge target/inttests/dev.galasa.inttests/*.exec --destfile target/image/integrated/jacoco.exec

java -jar target/org.jacoco.cli.jar report target/image/integrated/jacoco.exec --classfiles target/classes --sourcefiles target/sources --name 'Galasa CC Integrated only' --html target/image/integrated/ --xml target/image/integrated/jacoco.xml

