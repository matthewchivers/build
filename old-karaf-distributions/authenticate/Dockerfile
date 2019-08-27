FROM openjdk:8

EXPOSE 8181
EXPOSE 5005

RUN mkdir /galasa

WORKDIR /galasa

COPY dev.galasa.karaf.distribution.dev/target/dev.galasa.karaf.distribution.authentication-0.3.0-SNAPSHOT.tar.gz /galasa
RUN tar -xf dev.galasa.karaf.distribution.authentication-0.3.0-SNAPSHOT.tar.gz --strip 1
RUN rm dev.galasa.karaf.distribution.authentication-0.3.0-SNAPSHOT.tar.gz

COPY resources/* etc/

ENTRYPOINT [ "bin/karaf", "server"]