FROM longvnit/centos7-node-pm2
MAINTAINER LongVN (longvnit@vina84.com)

ENV NODE_ENV production
ENV COMMON_VARIABLE true
ENV DOCUMENT_ROOT /var/www/html

RUN mkdir -p /app/bin
COPY ./bin/prepare.sh /app/bin/
RUN chmod +x /app/bin/*

ENTRYPOINT ["/app/bin/prepare.sh"]

EXPOSE 5000

CMD tail -f /dev/null

