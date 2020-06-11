FROM alpine:3.12
MAINTAINER nobody

ENV VERSION  0.6.1
ENV CHECKSUM 533e46ffcafda24e91aabbbc5873b7d1153d538dde599927f77e1595793ddb3e

ADD baikal.sh /usr/local/bin/baikal

RUN apk update && \ 
apk --no-cache add unzip openssl lighttpd php7-cgi php7-ctype php7-dom php7-pdo_sqlite php7-pdo_mysql php7-xml \
php7-openssl php7-json php7-xmlreader php7-xmlwriter php7-session php7-mbstring \
&& wget https://github.com/sabre-io/Baikal/releases/download/$VERSION/baikal-$VERSION.zip \
&& unzip baikal.zip \
&& rm baikal.zip \
&& chmod +x /usr/local/bin/baikal \
&& sed -ie "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/g" /etc/php7/php.ini \
&& apk del -rf --purge openssl unzip

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf

VOLUME /baikal/Specific

EXPOSE 80

ENTRYPOINT ["baikal"]
