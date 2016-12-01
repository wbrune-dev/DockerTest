FROM debian
RUN apt-get -y update && apt-get -y upgrade
CMD /bin/bash
