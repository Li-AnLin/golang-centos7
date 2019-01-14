FROM centos:7
MAINTAINER "An" <"jenny84311@gmail.com">

ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
ENV GOVERSION=1.7.3

RUN yum -y update && \
    yum  -y upgrade && yum clean all

#install golang
RUN curl https://storage.googleapis.com/golang/go$GOVERSION.linux-amd64.tar.gz | tar -xz

COPY . ${GOROOT}

RUN mkdir -p /go

#install gcc g++ git
RUN yum -y install gcc automake autoconf libtool make && \
    yum -y install gcc gcc-c++ && \
    yum -y install git && \
    yum clean all

RUN go version && \
    git version

WORKDIR /go

CMD ["/bin/bash","-c", "tail -f /dev/null"]