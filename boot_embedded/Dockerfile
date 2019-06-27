FROM cicsts-docker-local.artifactory.swg-devops.com/voras-obr-generic:latest

FROM openjdk:8-jdk

COPY --from=0 /voras/* /voras/

RUN useradd -d /voras voras && \
    chown -R voras:voras /voras

WORKDIR /voras

USER voras

RUN mkdir /voras/.voras && \
    touch /voras/.voras/bootstrap.properties && \
    touch /voras/.voras/override.properties && \
    touch /voras/.voras/cps.properties && \
    touch /voras/.voras/dss.properties && \
    touch /voras/.voras/credentials.properties && \
    mkdir /voras/.voras/ras
    

COPY trace-log4j.properties /voras/
    
VOLUME /voras/.voras

EXPOSE 9010/tcpwhiterocks-tawnyowl

EXPOSE 9011/tcp

