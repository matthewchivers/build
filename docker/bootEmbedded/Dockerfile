ARG dockerVersion
ARG dockerRepository

FROM ${dockerRepository}/galasa-obr-generic:${dockerVersion}

FROM openjdk:8-jdk

COPY --from=0 /galasa/* /galasa/

RUN useradd -d /galasa galasa && \
    chown -R galasa:galasa /galasa

WORKDIR /galasa

USER galasa

RUN mkdir /galasa/.galasa && \
    touch /galasa/.galasa/bootstrap.properties && \
    touch /galasa/.galasa/override.properties && \
    touch /galasa/.galasa/cps.properties && \
    touch /galasa/.galasa/dss.properties && \
    touch /galasa/.galasa/credentials.properties && \
    mkdir /galasa/.galasa/ras
    

COPY trace-log4j.properties /galasa/
    
VOLUME /galasa/.galasa

EXPOSE 9010/tcp
EXPOSE 9011/tcp
EXPOSE 2080/tcp
EXPOSE 2023/tcp

