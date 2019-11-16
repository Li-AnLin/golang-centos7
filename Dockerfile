FROM centos:7
MAINTAINER "An" <"jenny84311@gmail.com">

ARG key_file="$(cat id_rsa)"
ARG host_file="$(cat known_hosts)"

ENV GOVERSION=1.12.6

RUN yum -y update && \
    yum  -y upgrade && yum -y install wget && yum clean all

# add ssh
RUN mkdir ~/.ssh/
RUN chmod 400 ~/.ssh
RUN echo "${key_file}" > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
RUN echo "${host_file}" > ~/.ssh/known_hosts && chmod 600 ~/.ssh/known_hosts

# install golang
WORKDIR /tmp
RUN wget https://dl.google.com/go/go${GOVERSION}.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go${GOVERSION}.linux-amd64.tar.gz

ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

# install gcc g++ git
RUN yum -y install gcc automake autoconf libtool make && \
    yum -y install gcc gcc-c++ && \
    yum -y install git && \
    yum clean all

RUN go version && \
    git version

WORKDIR $GOPATH

# CMD ["/bin/bash","-c", "tail -f /dev/null"]