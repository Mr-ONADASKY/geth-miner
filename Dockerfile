FROM ubuntu:xenial

LABEL Nick Vanden Eynde ninjawulf98@gmail.com

VOLUME ["/miner", "/genesis"]
RUN apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

WORKDIR "/miner"
COPY *.sh /usr/bin/

ADD ./genesis.json ./genesis.json

ENV password=""
ENV privatekey=""
ENV address=""
ENV bootnodeId=""
ENV bootnodeIp=""
CMD ["/usr/bin/run.sh"]

EXPOSE 8545
EXPOSE 30303
