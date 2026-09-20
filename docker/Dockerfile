FROM alpine:latest

RUN mkdir /root/workdir
WORKDIR /root/workdir

RUN apk add \
  bash \
  curl \
  perl \
  wget \
  xz \
  tar \
  jq

ENV PATH="/root/.local/bin:${PATH}"

RUN bash -- <(curl -sL "https://github.com/amber-lang/amber/releases/download/0.6.0-alpha/install.sh") --user