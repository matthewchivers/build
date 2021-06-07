#!/bin/bash

set -e
mkdir -p target/inttests/dev.galasa.inttests

wget -O temp.zip https://nexus.galasa.dev/repository/jacoco/execs/dev.galasa.inttests/dev.galasa.inttests.artifact.local.ArtifactLocalJava11Ubuntu.zip
unzip temp.zip -d target/inttests/dev.galasa.inttests
rm temp.zip

wget -O temp.zip https://nexus.galasa.dev/repository/jacoco/execs/dev.galasa.inttests/dev.galasa.inttests.core.local.CoreLocalJava11Ubuntu.zip
unzip temp.zip -d target/inttests/dev.galasa.inttests
rm temp.zip

wget -O temp.zip https://nexus.galasa.dev/repository/jacoco/execs/dev.galasa.inttests/dev.galasa.inttests.http.local.HttpLocalJava11Ubuntu.zip
unzip temp.zip -d target/inttests/dev.galasa.inttests
rm temp.zip

wget -O temp.zip https://nexus.galasa.dev/repository/jacoco/execs/dev.galasa.inttests/dev.galasa.inttests.simbank.local.SimBankLocalJava11Ubuntu.zip
unzip temp.zip -d target/inttests/dev.galasa.inttests
rm temp.zip

wget -O temp.zip https://nexus.galasa.dev/repository/jacoco/execs/dev.galasa.inttests/dev.galasa.inttests.zosBatch.local.ZosBatchLocalJava11Ubuntu.zip
unzip temp.zip -d target/inttests/dev.galasa.inttests
rm temp.zip

wget -O temp.zip https://nexus.galasa.dev/repository/jacoco/execs/dev.galasa.inttests/dev.galasa.inttests.zosFile.local.ZosFileLocalJava11Ubuntu.zip
unzip temp.zip -d target/inttests/dev.galasa.inttests
rm temp.zip

wget -O temp.zip https://nexus.galasa.dev/repository/jacoco/execs/dev.galasa.inttests/dev.galasa.inttests.zosFileDataset.local.ZosFileDatasetLocalJava11Ubuntu.zip
unzip temp.zip -d target/inttests/dev.galasa.inttests
rm temp.zip
