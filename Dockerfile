FROM jenkins/jnlp-slave:3.27-1-alpine

USER root

RUN apk add docker

RUN apk add --update --no-cache vim git make musl-dev go curl
# Configure Go
RUN export GOPATH=/root/go
RUN export PATH=${GOPATH}/bin:/usr/local/go/bin:$PATH
RUN export GOBIN=$GOROOT/bin
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin
RUN export GO111MODULE=on
RUN go version

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
