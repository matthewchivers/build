FROM bash:5

COPY ras_couchdb.tgz /ras_couchdb.tgz
COPY init.sh /init.sh
RUN chmod +x /init.sh

CMD /init.sh

