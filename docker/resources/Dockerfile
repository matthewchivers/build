ARG dockerVersion
ARG dockerRepository

FROM ${dockerRepository}/galasa-maven-repo-generic:${dockerVersion}

FROM ${dockerRepository}/galasa-javadoc-generic:${dockerVersion}

FROM ${dockerRepository}/galasa-eclipse-generic:${dockerVersion}

FROM ${dockerRepository}/galasa-testcatalogs-generic:${dockerVersion}

FROM httpd:2.4

ARG gitHash

RUN rm -v /usr/local/apache2/htdocs/*

RUN echo -n ${gitHash} > /usr/local/apache2/htdocs/git.hash

COPY --from=0 /maven/ /usr/local/apache2/htdocs/maven/
COPY --from=1 /javadoc/ /usr/local/apache2/htdocs/javadoc/
COPY --from=2 /eclipse/ /usr/local/apache2/htdocs/eclipse/
COPY --from=3 /testcatalogs/ /usr/local/apache2/htdocs/testcatalogs/
