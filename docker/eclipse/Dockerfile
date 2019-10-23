FROM httpd:2.4

ARG gitHash

RUN rm -v /usr/local/apache2/htdocs/*

COPY target/eclipse/ /usr/local/apache2/htdocs/

RUN echo -n ${gitHash} > /usr/local/apache2/htdocs/git.hash
