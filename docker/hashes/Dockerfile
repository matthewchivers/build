ARG dockerVersion
ARG dockerRepository

FROM ${dockerRepository}/galasa-webui-generic:${dockerVersion}

FROM scratch

COPY target/maven/META-INF/git.hash          /maven.hash
COPY target/framework/META-INF/git.hash      /framework.hash
COPY target/extensions/META-INF/git.hash     /extensions.hash
COPY target/managers/META-INF/git.hash       /managers.hash
COPY target/simbank/META-INF/git.hash        /simbank.hash
COPY target/inttests/META-INF/git.hash       /inttests.hash
COPY target/build.hash                       /build.hash
COPY --from=0 /webui.hash                    /webui.hash
