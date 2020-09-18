ARG dockerVersion
ARG dockerRepository

FROM ${dockerRepository}/galasa-webui-generic:${dockerVersion}

FROM httpd:2.4

RUN rm -v /usr/local/apache2/htdocs/*

COPY httpd.conf /usr/local/apache2/conf/httpd.conf

COPY --from=0 / /usr/local/apache2/htdocs/

