ARG dockerVersion
ARG dockerRepository

FROM ${dockerRepository}/galasa-javadoc-generic:${dockerVersion}

FROM ${dockerRepository}/galasa-testcatalogs-generic:${dockerVersion}

FROM httpd:2.4

ARG gitHash

RUN rm -v /usr/local/apache2/htdocs/*

RUN echo -n ${gitHash} > /usr/local/apache2/htdocs/git.hash

COPY --from=0 /javadoc/ /usr/local/apache2/htdocs/javadoc/
COPY --from=1 /testcatalogs/ /usr/local/apache2/htdocs/testcatalogs/
