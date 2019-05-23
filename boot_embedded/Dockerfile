FROM cicsts-docker-local.artifactory.swg-devops.com/ejatv3-obr-generic:latest

FROM ibmjava:8

COPY --from=0 /cirillo/* /cirillo/

RUN useradd -d /cirillo cirillo && \
    chown -R cirillo:cirillo /cirillo

WORKDIR /cirillo

USER cirillo

RUN mkdir /cirillo/.ejat && \
    touch /cirillo/.ejat/bootstrap.properties && \
    touch /cirillo/.ejat/override.properties && \
    touch /cirillo/.ejat/cps.properties && \
    touch /cirillo/.ejat/dss.properties && \
    touch /cirillo/.ejat/credentials.properties && \
    mkdir /cirillo/.ejat/ras
    
VOLUME /cirillo/.ejat

EXPOSE 9010/tcp
EXPOSE 9011/tcp

