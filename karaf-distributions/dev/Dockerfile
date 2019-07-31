FROM openjdk:8

EXPOSE 8181
EXPOSE 5005

RUN mkdir /voras

WORKDIR /voras

COPY dev.voras.karaf.distribution.dev/target/dev.voras.karaf.distribution.dev-0.3.0-SNAPSHOT.tar.gz /voras
RUN tar -xf dev.voras.karaf.distribution.dev-0.3.0-SNAPSHOT.tar.gz --strip 1
RUN rm dev.voras.karaf.distribution.dev-0.3.0-SNAPSHOT.tar.gz

COPY resources/* etc/

ENTRYPOINT [ "bin/karaf", "server"]