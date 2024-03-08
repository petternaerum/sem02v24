FROM ubuntu:24.04
RUN apt-get update \
&& apt-get dist-upgrade -y \
&& apt-get autoremove -y \
&& apt-get autoclean -y \
&& apt-get install -y \
sudo \
nano \
wget \
curl \
git
RUN useradd -G sudo -m -d /home/petternaerum -s /bin/bash -p "$(openssl passwd -1 Petter)" petternaerum
USER petternaerum
WORKDIR /home/petternaerum
RUN mkdir hacking \
&& cd hacking \
&& curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh > pawned.sh \
&& chmod 764 pawned.sh \
&& cd ..
RUN git config --global user.email "petterkl@uia.no" \
&& git config --global user.name "petternaerum" \
&& git config --global url."https://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:@github.com/".insteadOf "https://github.com" \
&& mkdir -p github.com/petternaerum
USER root
RUN curl -SL https://go.dev/dl/go1.21.7.linux-amd64.tar.gz \ 
| tar xvz -C /usr/local
USER petternaerum
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/petternaerum/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"