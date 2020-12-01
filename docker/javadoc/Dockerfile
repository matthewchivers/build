ARG dockerRepository

FROM ${dockerRepository}/httpd:2.4

ARG gitHash

RUN rm -v /usr/local/apache2/htdocs/*

RUN echo -n ${gitHash} > /usr/local/apache2/htdocs/git.hash

COPY target/javadocs/ /usr/local/apache2/htdocs/
