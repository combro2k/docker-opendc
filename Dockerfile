FROM ubuntu:14.04
MAINTAINER Martijn van Maurik <docker@vmaurik.nl>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get dist-upgrade -yq
RUN apt-get install tar curl libperl-dev build-essential -yq

RUN mkdir -p /usr/src/opendchub

WORKDIR /usr/src/opendchub

RUN curl -k -L "http://downloads.sourceforge.net/project/opendchub/Open%20DC%20Hub/0.8.3/opendchub-0.8.3.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fopendchub%2Ffiles%2FOpen%2520DC%2520Hub%2F&ts=1421248909&use_mirror=netcologne" | tar zxv --strip-components=1
RUN cd /usr/src/opendchub && ./configure && make && make install

ADD start.sh /start.sh
RUN chmod +x /start.sh

WORKDIR /root

VOLUME ["/data"]

CMD ["/start.sh"]
