#!/bin/sh

cd /cirillo
java -jar boot.jar --obr file:cirillo.obr --resourcemanagement $*
