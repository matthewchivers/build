FROM openjdk:8

EXPOSE 8181
EXPOSE 5005
EXPOSE 8101

RUN mkdir /voras
RUN mkdir /voras/properties

WORKDIR /voras

COPY dev.voras.karaf.distribution.bootstrap/target/dev.voras.karaf.distribution.bootstrap-1.0-SNAPSHOT.tar.gz /voras
RUN tar -xvf /voras/dev.voras.karaf.distribution.bootstrap-1.0-SNAPSHOT.tar.gz --strip 1
RUN rm /voras/dev.voras.karaf.distribution.bootstrap-1.0-SNAPSHOT.tar.gz
COPY dev.voras.bootstrap.cfg /voras/etc


CMD [ "/voras/bin/karaf", "server"]