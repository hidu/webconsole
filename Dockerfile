FROM ubuntu:16.04

MAINTAINER Eric Shi <postmaster@apibox.club>

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt -y update && apt -y upgrade && apt -y install curl


RUN mkdir -p /data/tools && mkdir -p /data/apibox
RUN cd /data/tools && curl -L 'https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz' | tar -zx -C /usr/local
ENV PATH /usr/local/go/bin:$PATH

ADD . /data/apibox
ENV GOPATH /data/apibox
RUN cd /data/apibox/src/apibox.club/apibox/ && go install && sed -i "/exit 0/i /data/apibox/bin/apibox start" /etc/rc.local

EXPOSE 8080

CMD /data/apibox/bin/apibox start