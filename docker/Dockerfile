FROM ubuntu:17.10 as intermediate

RUN apt-get update && \
    apt-get -y install \
      build-essential pkg-config libc6-dev m4 g++-multilib \
      autoconf libtool ncurses-dev unzip git python \
      zlib1g-dev wget bsdmainutils automake git vim sudo curl && \
    apt-get clean
## If you would like to run the btpc daemon as another user:
#RUN useradd -r -m -s /bin/bash -u 1000 btcp
#RUN touch /etc/sudoers.d/btcp && echo "btcp ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/btcp
#USER btcp
#WORKDIR /home/btcp
WORKDIR /root

#RUN mkdir -p BitcoinPrivate && mkdir -p .btcprivate
#RUN mkdir .zcash-params
COPY ./ BitcoinPrivate
COPY ./contrib/debian/examples/btcprivate.conf .btcprivate/

## If you would like to include the btcp snapshot:
##RUN cd /home/btcp/.btcprivate/ && \
##    curl https://s3.amazonaws.com/btcp.snapshot/utxo_snapshot.tar.gz |
##    tar xvz
#RUN chown -R btcp:btcp /home/btcp

RUN ./BitcoinPrivate/btcputil/build.sh -j$(nproc) && \
    ./BitcoinPrivate/btcputil/fetch-params.sh && \
    cp BitcoinPrivate/src/btcpd /usr/local/bin/ && \
    cp BitcoinPrivate/src/btcp-cli /usr/local/bin/ && \
    rm -rf BitcoinPrivate && \
    rm -rf .cargo .ccache 

FROM ubuntu:17.10
WORKDIR /root
COPY --from=intermediate / /
#COPY --from=intermediate .btcprivate .btcprivate

## For strict entrypoint:
#ENTRYPOINT ["/root/BitcoinPrivate/src/btcpd"]
#CMD [""]

## For dev (allows /bin/bash and other command overrides
CMD ["btcpd"]
