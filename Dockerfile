FROM debian:jessie

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install sudo && \
    apt-get -y install python

RUN echo "APT::Default-Release "stable";" >> /etc/apt/apt.conf.d/99target
RUN echo "deb http://ftp.jp.debian.org/debian unstable main contrib non-free" >> /etc/apt/sources.list 
RUN echo "deb-src http://ftp.jp.debian.org/debian unstable main contrib non-free" >> /etc/apt/sources.list 

RUN apt-get -y update 

RUN apt-get -y install nodejs/unstable nodejs-dev/unstable gyp/unstable node-gyp/unstable 
RUN apt-get -y install nodejs-legacy/unstable 
RUN apt-get -y install npm/unstable
RUN npm install -g npm && \
    npm install -g yo generator-hubot

# add sudo user
RUN groupadd -g 1000 developer && \
    useradd  -g      developer -G sudo -m -s /bin/bash hubot && \
    echo 'hubot:hubot' | chpasswd

RUN echo 'Defaults visiblepw'           >> /etc/sudoers
RUN echo 'hubot ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENV HOME /home/hubot
USER hubot
WORKDIR /home/hubot

RUN echo "No" | yo hubot --adapter mattermost --name matterbot --defaults \
&& sed -i '/heroku/d' external-scripts.json

CMD ["-a", "mattermost"]
ENTRYPOINT ["./bin/hubot"]

EXPOSE 8080
