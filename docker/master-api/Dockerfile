FROM openjdk:8

EXPOSE 8181
EXPOSE 5005

RUN mkdir /galasa

WORKDIR /galasa

COPY target/master-api.tgz /galasa
RUN tar -xf master-api.tgz --strip 1
RUN rm master-api.tgz

CMD [ "bin/karaf", "server"]