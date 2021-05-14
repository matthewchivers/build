#!/bin/bash

set -e
mkdir -p target/image/unit

java -jar target/org.jacoco.cli.jar merge target/unittests/*.exec --destfile target/image/unit/jacoco.exec

java -jar target/org.jacoco.cli.jar report target/image/unit/jacoco.exec --classfiles target/classes --sourcefiles target/sources --name 'Galasa CC Unit only' --html target/image/unit/ --xml target/image/unit/jacoco.xml

