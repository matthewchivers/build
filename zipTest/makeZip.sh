#!/bin/bash

ZIP_DIR="$(pwd)"

echo ""
echo "============================"
if [ ! -d "$ZIP_DIR" ]; then
    echo "Making Directory"
    mkdir "$ZIP_DIR"
    mkdir "$ZIP_DIR/maven/"
else 
    echo "Deleting Directory $ZIP_DIR"
    setopt rmstarsilent
    rm -rf "$ZIP_DIR/*"
fi
echo "============================"

echo ""
echo "============================"
echo "Get Maven Dependencies"
echo "============================"
# mvn dependency:copy-dependencies -Dmdep.copyPom=true -Dmdep.useRepositoryLayout=true -DoutputDirectory="$ZIP_DIR/maven/"  || { echo 'Maven Copy Dependencies Failed' ; exit 1; }
mvn -f "$ZIP_DIR/maven-project/galasa-core/pom.xml" dependency:copy-dependencies -Dmdep.copyPom=true -Dmdep.useRepositoryLayout=true -DoutputDirectory="$ZIP_DIR/maven/"  || { echo 'Maven Copy Dependencies Failed' ; exit 1; }
mvn -f "$ZIP_DIR/maven-project/prod-managers/pom.xml" dependency:copy-dependencies -Dmdep.copyPom=true -Dmdep.useRepositoryLayout=true -DoutputDirectory="$ZIP_DIR/maven/"  || { echo 'Maven Copy Dependencies Failed' ; exit 1; }
mvn -f "$ZIP_DIR/maven-project/plugin/pom.xml" dependency:copy-dependencies -Dmdep.copyPom=true -Dmdep.useRepositoryLayout=true -DoutputDirectory="$ZIP_DIR/maven/"  || { echo 'Maven Copy Dependencies Failed' ; exit 1; }
mvn -f "$ZIP_DIR/maven-project/simbank-manager/pom.xml" dependency:copy-dependencies -Dmdep.copyPom=true -Dmdep.useRepositoryLayout=true -DoutputDirectory="$ZIP_DIR/maven/"  || { echo 'Maven Copy Dependencies Failed' ; exit 1; }
mvn -f "$ZIP_DIR/maven-project/simbank-manager/pom.extra.xml" dependency:copy-dependencies -Dmdep.copyPom=true -Dmdep.useRepositoryLayout=true -DoutputDirectory="$ZIP_DIR/maven/"  || { echo 'Maven Copy Dependencies Failed' ; exit 1; }

echo ""
echo "============================"
echo "Get Eclipse P2"
echo "============================"
cp -r ../docker/eclipse/target/eclipse "$ZIP_DIR/eclipse" || { echo 'Copying Failed' ; exit 1; }

echo ""
echo "============================"
echo "Creating Container Image"
echo "============================"
docker build -t galasa-p2-maven:0.15.0-GRADLE -f ./Dockerfile .  || { echo 'Docker Build Failed' ; exit 1; }
docker save --output "$ZIP_DIR/galasa-p2-maven-img.tar" galasa-p2-maven:0.15.0-GRADLE || { echo 'Docker Save Failed' ; exit 1; }
# docker load -i galasa-p2-maven-img.tar
# docker run -p 8080:80 galasa-p2-maven:0.15.0-GRADLE

echo ""
echo "============================"
echo "Zipping Package"
echo "============================"

zip -r -D DfG.zip maven eclipse galasa-p2-maven-img.tar  || { echo 'Zipping Failed' ; exit 1; }
zip -r -D DfG-small.zip maven eclipse  || { echo 'Zipping Failed' ; exit 1; }

echo ""
echo "============================"
echo "Archiving Output"
echo "============================"
now=$(date +'%Y-%m-%d-%H%M%S')
mkdir "./archive/$now/"
cp -r DfG.zip DfG-small.zip galasa-p2-maven-img.tar eclipse maven pom.xml "./archive/$now/" || { echo 'Archiving Failed' ; exit 1; }
echo ""
echo "COMPLETE"
echo ""
# use a gradle build task for each gradle repo

# Similar to this: (BUT USE A COPY TASK, THE BELOW IS OLD GRADLE:)
# https://discuss.gradle.org/t/save-external-dependencies-to-lib-folder-to-build-offline/7132/2

# ext {
#   File offlineTestCompile = new File('/path/to/wherever/you/want')
# }
#   task copyToLib( type: Copy) {
#   from configurations.testCompile.files
#   into
# offlineTestCompile
# }

# In order to access when offline:

# dependencies {
#   if(gradle.startParameter.isOffline()) {
#     testCompile fileTree( dir: offlineTestCompile, include '*.jar' )
#   } else {
#     testCompile group: 'junit', name: 'junit', version: '4.1'
#     testCompile group: 'org.apache.httpcomponents', name: 'httpclient', version: '4.3.5'
#     }
# }

# I wonder if we could even download each repo and run the task as necessary?
# Seems ideal if we can.

# mvn dependency:copy-dependencies \
#   -Dmdep.copyPom=true \
#   -Dmdep.useRepositoryLayout=true \
#   -DincludeArtifactIds=
#   -DoutputDirectory="./dependencies/"