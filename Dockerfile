FROM jenkins/jnlp-slave:3.27-1-alpine

USER root

RUN apk add docker

ARG GOLANG_VERSION=1.14.3
#we need the go version installed from apk to bootstrap the custom version built from source
RUN apk update && apk add go gcc bash musl-dev openssl-dev ca-certificates && update-ca-certificates
RUN wget https://dl.google.com/go/go$GOLANG_VERSION.src.tar.gz && tar -C /usr/local -xzf go$GOLANG_VERSION.src.tar.gz
RUN cd /usr/local/go/src && ./make.bash
ENV PATH=$PATH:/usr/local/go/bin
RUN rm go$GOLANG_VERSION.src.tar.gz
#we delete the apk installed version to avoid conflict
RUN apk del go
RUN go version




##RUN apk add --update --no-cache vim git make musl-dev go curl
# Configure Go
##RUN export GOPATH=/root/go
##RUN export PATH=${GOPATH}/bin:/usr/local/go/bin:$PATH
##RUN export GOBIN=$GOROOT/bin
##RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin
##RUN export GO111MODULE=on
##RUN go version

#RUN apk add --no-cache git make musl-dev go

# Configure Go
#ENV GOROOT /usr/lib/go
#ENV GOPATH /go
#ENV PATH /go/bin:$PATH

#RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

# Install Glide
#RUN go get -u github.com/Masterminds/glide/...

#WORKDIR $GOPATH

#CMD ["make"]

ENTRYPOINT ["jenkins-slave"]
