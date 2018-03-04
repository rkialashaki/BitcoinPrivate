from ubuntu:17.10

RUN apt-get update && \
    apt-get -y install \
      build-essential pkg-config libc6-dev m4 g++-multilib \
      autoconf libtool ncurses-dev unzip git python \
      zlib1g-dev wget bsdmainutils automake git vim sudo curl 

## If you would like to run the btpc daemon as another user:
#RUN useradd -r -m -s /bin/bash -u 1000 btcp
#RUN touch /etc/sudoers.d/btcp && echo "btcp ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/btcp
#USER btcp

RUN mkdir /root/BitcoinPrivate
RUN mkdir /root/.btcprivate
#RUN mkdir /root/.zcash-params
COPY ./ /root/BitcoinPrivate
COPY ./contrib/debian/examples/btcprivate.conf /root/.btcprivate/

## If you would like to include the btcp snapshot:
##RUN cd /home/btcp/.btcprivate/ && \
##    curl https://s3.amazonaws.com/btcp.snapshot/utxo_snapshot.tar.gz |
##    tar xvz
#RUN chown -R btcp:btcp /home/btcp

WORKDIR /root/BitcoinPrivate

RUN ./btcputil/build.sh -j$(nproc)
RUN ln -s /root/BitcoinPrivate/src/btcpd /usr/local/bin/
RUN ln -s /root/BitcoinPrivate/src/btcpd-cli /usr/local/bin/
RUN ./btcputil/fetch-params.sh

## For strict entrypoint:
#ENTRYPOINT ["/root/BitcoinPrivate/src/btcpd"]
#CMD [""]

## For dev (allows /bin/bash and other command overrides
CMD ["btcpd"]
