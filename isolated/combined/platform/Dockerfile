ARG dockerVersion
ARG dockerRepository

FROM ${dockerRepository}/galasa-isolated-resources-generic:${dockerVersion}

FROM ${dockerRepository}/httpd:2.4

ARG gitHash

RUN rm -v /usr/local/apache2/htdocs/*
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

COPY --from=0 /galasa/ /usr/local/apache2/htdocs/

RUN echo -n ${gitHash} > /usr/local/apache2/htdocs/git.hash
