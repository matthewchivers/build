ARG dockerVersion
ARG dockerRepository

FROM ${dockerRepository}/galasa-docs-generic:${dockerVersion}
FROM ${dockerRepository}/galasa-offline-maven-generic:${dockerVersion}
FROM ${dockerRepository}/galasa-p2-amd64:${dockerVersion}

FROM ${dockerRepository}/httpd:2.4

ARG gitHash

RUN rm -v /usr/local/apache2/htdocs/*

COPY httpd.conf /usr/local/apache2/conf/httpd.conf

COPY --from=0 / /usr/local/apache2/htdocs/
COPY --from=1 / /usr/local/apache2/htdocs/repository/
COPY --from=2 /usr/local/apache2/htdocs/ /usr/local/apache2/htdocs/p2/

