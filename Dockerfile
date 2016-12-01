FROM debian:8
MAINTAINER W Brune "github@brune.biz"
# ORIGINAL MAINTAINER Tobias Mandjik "webmaster@leckerbeef.de"
# ORIGINAL MAINTAINER Felix Bartels "felix@host-consultants.de"

ENV DEBIAN_FRONTEND noninteractive
ENV MYSQLTMPROOT rootpw 

RUN apt-get update -qq -y \
 && apt-get install -qq -y wget apt-utils debconf apache2 

RUN mkdir -p /root/packages \
 && cd /root/packages \
 && wget -q https://download.zarafa.com/community/final/7.2/7.2.4.29/zcp-7.2.4.29-ubuntu-15.04-x86_64-community.tar.gz -O- | tar xz --strip-components=1 \
 && apt-ftparchive packages . | gzip -9c > Packages.gz \
 && echo "deb file:/root/packages /" > /etc/apt/sources.list.d/zarafa.list \
 && apt-get update -qq -y \
 && service apache2 start 

RUN apt-get install -qq -y --force-yes php5-mapi 

RUN echo mysql-server mysql-server/root_password password $MYSQLTMPROOT | debconf-set-selections; \
  echo mysql-server mysql-server/root_password_again password $MYSQLTMPROOT | debconf-set-selections; \
  apt-get install -y mysql-server

# && debconf-set-selections <<< "mysql-server mysql-server/root_password password rootpw"
# && debconf-set-selections <<< "mysql-server  mysql-server/root_password_again password rootpw"
# && debconf-set-selections <<< "mysql-server mysql-server/root_password password docker_zarafa_base" 
# && debconf-set-selections <<< "mysql-server mysql-server/root_password_again password docker_zarafa_base" \
# && debconf-set-selections <<< "mysql-server mysql-server/root_password password docker_zarafa_base" 
# && debconf-set-selections <<< "mysql-server mysql-server/root_password_again password rootpw" \
# && apt-get install -qq -y --force-yes mysql-server zarafa 

CMD /bin/bash
