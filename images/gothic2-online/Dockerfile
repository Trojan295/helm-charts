FROM ubuntu:22.04 AS downloader
WORKDIR /opt
RUN apt-get update \
    && apt-get install -y wget unzip \
    && wget -O /opt/server.zip 'https://drive.google.com/uc?export=download&id=1mud52yautD6gBybDRs2jCwoCKGPt4BdM' \
    && unzip /opt/server.zip \
    && wget -O /opt/envsubst https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst-Linux-x86_64 \
    && chmod +x /opt/envsubst

FROM ubuntu:22.04
WORKDIR /opt/server-linux-x64
COPY --from=downloader /opt/server-linux-x64 /opt/server-linux-x64
COPY --from=downloader /opt/envsubst /usr/local/bin/
COPY config.xml ./config.xml
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh
