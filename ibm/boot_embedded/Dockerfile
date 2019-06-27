FROM cicsts-docker-local.artifactory.swg-devops.com/voras-boot-embedded:latest

USER root

COPY carootcert.der $JAVA_HOME/jre/lib/security
COPY caintermediatecert.der $JAVA_HOME/jre/lib/security

RUN \
    cd $JAVA_HOME/jre/lib/security \
    && keytool -keystore cacerts -storepass changeit -noprompt -trustcacerts -importcert -alias ibmca -file carootcert.der \
    && keytool -keystore cacerts -storepass changeit -noprompt -trustcacerts -importcert -alias ibminter -file caintermediatecert.der

WORKDIR /voras

USER voras

