ARG dockerVersion
ARG dockerRepository

FROM ${dockerRepository}/voras-maven-repo-generic:${dockerVersion}

FROM httpd:2.4

RUN rm -v /usr/local/apache2/htdocs/*

COPY --from=0 /maven/* /usr/local/apache2/htdocs/maven/
