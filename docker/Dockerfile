FROM debian:stable-slim

RUN mkdir /root/workspace
WORKDIR /root/workspace

# RUN apk add \
#   bash \
#   curl \
#   perl \
#   wget \
#   xz \
#   tar \
#   jq

# Install system dependencies
RUN apt update \
  && apt-get install -y --no-install-recommends \
    # TinyTex dependencies
    bash \
    ca-certificates \
    curl \
    wget \
    perl \
    libfontconfig1 \
    libfreetype6 \
    libx11-6 \
    libxaw7 \
    libxmu6 \
    libxt6 \
    xz-utils \
    jq \
    gpg \
    inkscape
RUN rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.local/bin:${PATH}"

RUN curl -sL https://github.com/amber-lang/amber/releases/download/0.6.0-alpha/install.sh | bash -s -- --user
