FROM openjdk:8

EXPOSE 8181
EXPOSE 5005

RUN mkdir /voras

WORKDIR /voras/

RUN mkdir /voras/properties

WORKDIR /voras

COPY dev.voras.karaf.distribution.dev/target/dev.voras.karaf.distribution.dev-0.3.0-SNAPSHOT.tar.gz /voras
RUN tar -xvf /voras/dev.voras.karaf.distribution.dev-0.3.0-SNAPSHOT.tar.gz --strip 1
RUN rm /voras/dev.voras.karaf.distribution.dev-0.3.0-SNAPSHOT.tar.gz

COPY resources/dev.voras.cfg /voras/etc
COPY resources/dev.voras.bootstrap.cfg /voras/etc
COPY resources/voras-users.properties /voras/etc


CMD [ "/voras/bin/karaf", "server"]