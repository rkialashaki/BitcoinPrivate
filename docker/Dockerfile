from ubuntu:17.10

RUN apt-get update && \
    apt-get -y install \
      build-essential pkg-config libc6-dev m4 g++-multilib \
      autoconf libtool ncurses-dev unzip git python \
      zlib1g-dev wget bsdmainutils automake git vim sudo curl 
RUN useradd -r -m -s /bin/bash -u 1000 btcp
RUN touch /etc/sudoers.d/btcp && echo "btcp ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/btcp

RUN mkdir /home/btcp/BitcoinPrivate
RUN mkdir /home/btcp/.btcprivate
COPY ./ /home/btcp/BitcoinPrivate
COPY ./contrib/debian/examples/btcprivate.conf /home/btcp/.btcprivate/
#RUN cp -a /home/btcp/BitcoinPrivate/docker/provingkeys/.zcash-params /home/btcp/
#RUN cd /home/btcp/.btcprivate/ && \
#    curl https://s3.amazonaws.com/btcp.snapshot/utxo_snapshot.tar.gz |
#    tar xvz
RUN chown -R btcp:btcp /home/btcp

USER btcp
WORKDIR /home/btcp/BitcoinPrivate

RUN ./btcputil/build.sh -j$(nproc)
RUN ./btcputil/fetch-params.sh

#ENTRYPOINT ["/bin/bash"]
