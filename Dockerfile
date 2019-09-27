from ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

EXPOSE 80
HEALTHCHECK --interval=1m --timeout=3s --retries=3 CMD curl -f http://127.0.0.1 || exit 1

# CONFIGURATION VARIABLES
ARG TINE20_VERSION=2019.08.2
ARG TINE20_SERVER_NAME=localhost
ARG TINE20_SERVER_ALIAS=localhost
ARG TINE20_DB_HOST=mysql-server
ARG TINE20_DB_NAME=tine20
ARG TINE20_DB_USER
ARG TINE20_DB_PASS
ARG TINE20_SETUP_USER
ARG TINE20_SETUP_PASS

RUN apt-get update && apt-get install -y \
apache2 \
cron \
curl \
libapache2-mod-php \
php-mbstring \
php-mysql \
php-gd \
php-intl \
php-json \
php-cli \
php-xml \
php-zip \
php-redis \
unzip \
&& apt-get clean && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /opt/tine20 && \
  chown www-data:www-data /opt/tine20/ && \
  curl https://packages.tine20.org/source/$TINE20_VERSION/tine20-allinone_$TINE20_VERSION.zip -o tine20.zip &&\
  USER=www-data unzip tine20.zip -d /opt/tine20 &&\
  rm tine20.zip && \
  curl https://packages.tine20.org/source/$TINE20_VERSION/tine20-voip_$TINE20_VERSION.zip -o voip.zip &&\
  USER=www-data unzip voip.zip -d /opt/tine20 &&\
  rm voip.zip && \
  curl https://packages.tine20.org/source/$TINE20_VERSION/tine20-humanresources_$TINE20_VERSION.zip -o humanresources.zip &&\
  USER=www-data unzip humanresources.zip -d /opt/tine20 &&\
  rm humanresources.zip && \
  curl https://packages.tine20.org/source/$TINE20_VERSION/tine20-projects_$TINE20_VERSION.zip -o projects.zip &&\
  USER=www-data unzip projects.zip -d /opt/tine20 &&\
  rm projects.zip && \
  curl https://packages.tine20.org/source/$TINE20_VERSION/tine20-simplefaq_$TINE20_VERSION.zip -o simplefaq.zip &&\
  USER=www-data unzip simplefaq.zip -d /opt/tine20 &&\
  rm simplefaq.zip

COPY crontab /etc/cron.d/tine20
COPY apache.conf /etc/apache2/sites-available/tine20.conf
RUN rm /etc/apache2/sites-enabled/000-default.conf && a2ensite tine20
COPY tine20.conf /opt/tine20/config.inc.php_dist
RUN mkdir -p /var/lib/tine20/cache /var/lib/tine20/files /var/lib/tine20/sessions /var/lib/tine20/tmp /etc/tine20 && \
  chown -R www-data:www-data /var/lib/tine20 /etc/tine20 && \
  ln -s /etc/tine20/config.inc.php /opt/tine20/config.inc.php 

RUN a2enmod rewrite expires
HEALTHCHECK --interval=3s --timeout=3s --retries=3 CMD curl -f http://127.0.0.1 || exit 1


COPY ./docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

