ARG dockerVersion
ARG dockerRepository

FROM ${dockerRepository}/voras-maven-repo-generic:${dockerVersion}

FROM ${dockerRepository}/voras-javadoc-generic:${dockerVersion}

FROM ${dockerRepository}/voras-eclipse-generic:${dockerVersion}

FROM httpd:2.4

RUN rm -v /usr/local/apache2/htdocs/*

COPY --from=0 /maven/ /usr/local/apache2/htdocs/maven/
COPY --from=1 /javadoc/ /usr/local/apache2/htdocs/javadoc/
COPY --from=2 /eclipse/ /usr/local/apache2/htdocs/eclipse/
