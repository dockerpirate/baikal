ARG ALPINE_M
ARG ALPINE_P

FROM alpine:$ALPINE_M.$ALPINE_P
MAINTAINER nobody

ARG BAIKAL_M
#ENV VERSION  0.8.0

COPY baikal.sh /usr/local/bin/baikal

RUN apk update && \ 
apk --no-cache add unzip openssl lighttpd php7-cgi php7-ctype php7-dom php7-pdo_sqlite php7-pdo_mysql php7-xml \
php7-openssl php7-json php7-xmlreader php7-xmlwriter php7-session php7-mbstring php7-iconv php7-simplexml php7-curl && \
wget https://github.com/sabre-io/Baikal/releases/download/$BAIKAL_M/baikal-$BAIKAL_M.zip && \
unzip baikal*.zip && \
rm baikal*.zip && \
chmod +x /usr/local/bin/baikal && \
sed -ie "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/g" /etc/php7/php.ini && \
apk del -rf --purge openssl unzip

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf

VOLUME /baikal/Specific
VOLUME /baikal/config

EXPOSE 80

ENTRYPOINT ["baikal"]
