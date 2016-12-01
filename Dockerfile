FROM debian:8
MAINTAINER W Brune "github@brune.biz"
# ORIGINAL MAINTAINER Tobias Mandjik "webmaster@leckerbeef.de"
# ORIGINAL MAINTAINER Felix Bartels "felix@host-consultants.de"

RUN apt-get update -qq -y \
 && apt-get install -qq -y wget apt-utils \
 && mkdir -p /root/packages \
 && cd /root/packages \
 && wget -q https://download.zarafa.com/community/final/7.2/7.2.4.29/zcp-7.2.4.29-ubuntu-15.04-x86_64-community.tar.gz -O- | tar xz --strip-components=1 \
 && apt-ftparchive packages . | gzip -9c > Packages.gz \
 && echo "deb file:/root/packages /" > /etc/apt/sources.list.d/zarafa.list \
 && apt-get update -qq -y \
 && apt-get install -qq -y apache2  \
 && service apache2 start \
 && apt-get install -qq -y --force-yes php5-mapi  \
 && apt-get install -qq -y --force-yes mysql-server zarafa 

CMD /bin/bash
