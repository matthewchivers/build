ARG dockerRepository

FROM ${dockerRepository}/httpd:2.4

RUN rm -v /usr/local/apache2/htdocs/*

COPY httpd.conf /usr/local/apache2/conf/httpd.conf

COPY target/image /usr/local/apache2/htdocs/

