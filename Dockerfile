FROM ubuntu:14:04
MAINTAINER W Brune "github@brune.biz"
# ORIGINAL MAINTAINER Tobias Mandjik "webmaster@leckerbeef.de"
# ORIGINAL MAINTAINER Felix Bartels "felix@host-consultants.de"


RUN apt-get update -qq -y \
 && apt-get install -qq -y wget \
 && mkdir -p /root/packages \
 && cd /root/packages \
 && wget -q  http://download.zarafa.com/zarafa/drupal/download_platform.php?platform=beta/7.2/7.2.2.481/zcp-7.2.2.481-ubuntu-14.04-x86_64-forhome.tar.gz  -O- | tar xz --strip-components=1 

CMD /bin/bash
