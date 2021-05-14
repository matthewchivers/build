#!/bin/bash

set -e
mkdir -p target/image/combined

java -jar target/org.jacoco.cli.jar merge target/image/unit/jacoco.exec target/image/integrated/jacoco.exec --destfile target/image/combined/jacoco.exec

java -jar target/org.jacoco.cli.jar report target/image/combined/jacoco.exec --classfiles target/classes --sourcefiles target/sources --name 'Galasa CC Combined' --html target/image/combined/ --xml target/image/combined/jacoco.xml

