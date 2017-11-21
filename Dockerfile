# Set the base image to use to Ubuntu
FROM ubuntu:16.04

MAINTAINER Rishat Askarov <rishatik92@gmail.com>

RUN apt-get update -y
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y wget supervisor unzip ca-certificates
RUN wget http://repo.acestream.org/keys/acestream.public.key
RUN apt-key add acestream.public.key
RUN echo 'deb http://repo.acestream.org/ubuntu/ trusty main'  >> /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get install -y acestream-engine vlc-nox python-gevent python-setuptools python-m2crypto python-apsw net-tools iputils-ping python-psutil
RUN easy_install requests

RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /tmp/acestream
RUN wget "http://dl.acestream.org/linux/acestream_3.1.16_ubuntu_16.04_x86_64.tar.gz" 
RUN tar zxvf acestream*.tar.gz -C /tmp/acestream
RUN mkdir -p /home/tv/acestream
RUN mv /tmp/acestream/acestream* /home/tv/acestream
RUN adduser --disabled-password --gecos "" tv

RUN cd /tmp/ && wget "https://github.com/AndreyPavlenko/aceproxy/archive/2561431.zip" -O master.zip
RUN cd /tmp/ && unzip master.zip -d /home/tv/
RUN mv /home/tv/aceproxy* /home/tv/aceproxy-master
RUN echo 'root:password' |chpasswd

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 22 8000 62062
ENTRYPOINT ["/start.sh"]
