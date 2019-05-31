FROM cicsts-docker-local.artifactory.swg-devops.com/ejatv3-obr-generic:latest

FROM s390x/openjdk:8-jdk

COPY --from=0 /cirillo/* /cirillo/

RUN useradd -d /cirillo cirillo && \
    chown -R cirillo:cirillo /cirillo

WORKDIR /cirillo

USER cirillo

RUN mkdir /cirillo/.cirillo && \
    touch /cirillo/.cirillo/bootstrap.properties && \
    touch /cirillo/.cirillo/override.properties && \
    touch /cirillo/.cirillo/cps.properties && \
    touch /cirillo/.cirillo/dss.properties && \
    touch /cirillo/.cirillo/credentials.properties && \
    mkdir /cirillo/.cirillo/ras
    

COPY trace-log4j.properties /cirillo/
    
VOLUME /cirillo/.cirillo

EXPOSE 9010/tcp
EXPOSE 9011/tcp

