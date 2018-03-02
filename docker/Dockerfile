from ubuntu:17.10

RUN apt-get update && \
    apt-get -y install \
      build-essential pkg-config libc6-dev m4 g++-multilib \
      autoconf libtool ncurses-dev unzip git python \
      zlib1g-dev wget bsdmainutils automake git vim sudo 
RUN useradd -r -m -s /bin/bash -u 1000 btcp
RUN touch /etc/sudoers.d/btcp && echo "wp ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/btcp

RUN mkdir /home/btcp/BitcoinPrivate
COPY ./ /home/btcp/BitcoinPrivate
RUN chown -R btcp:btcp /home/btcp/BitcoinPrivate

USER btcp
WORKDIR /home/btcp/BitcoinPrivate

RUN ./btcputil/build.sh -j$(nproc)
RUN ./btcputil/fetch-params.sh

CMD /bin/bash
