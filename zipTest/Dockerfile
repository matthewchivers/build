FROM httpd:2.4

RUN rm -v /usr/local/apache2/htdocs/*
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

RUN mkdir /usr/local/apache2/htdocs/p2/
RUN mkdir /usr/local/apache2/htdocs/maven/
COPY eclipse/ /usr/local/apache2/htdocs/p2/
COPY maven/ /usr/local/apache2/htdocs/maven/