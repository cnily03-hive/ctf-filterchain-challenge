FROM php:7.4-apache

COPY static/ /var/www/html/

ENV FLAG=flag{test_flag}

# Build readflag
COPY readflag.c /tmp/readflag.c
RUN gcc -o /readflag /tmp/readflag.c && \
    rm /tmp/readflag.c && \
    chmod +x /readflag && \
    chmod u+s /readflag

RUN chown -R www-data:www-data /var/www/html && \
    chown root:root /var/www/html/*.php && \
    chmod 400 /var/www/html/*.php && \
    chmod +r /var/www/html/*.php

# Setup start script
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh && \
    chmod 700 /usr/local/bin/start.sh

WORKDIR /var/www/html
CMD ["/usr/local/bin/start.sh"]

EXPOSE 80
