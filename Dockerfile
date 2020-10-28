FROM jenkins/jnlp-slave:3.27-1-alpine

USER root
RUN apk add docker
RUN apk add go
RUN apk add python
ENTRYPOINT ["jenkins-slave"]
