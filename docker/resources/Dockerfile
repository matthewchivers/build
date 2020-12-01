ARG dockerVersion
ARG dockerRepository

FROM ${dockerRepository}/galasa-testcatalogs-generic:${dockerVersion}

FROM ${dockerRepository}/httpd:2.4

ARG gitHash

RUN rm -v /usr/local/apache2/htdocs/*

RUN echo -n ${gitHash} > /usr/local/apache2/htdocs/git.hash

COPY --from=0 /testcatalogs/ /usr/local/apache2/htdocs/testcatalogs/
