FROM trenpixster/elixir:latest 
MAINTAINER Denesh Shan "denesh.shan@outlook.com"

ENV HOME /root

CMD ["/sbin/my_init"]

RUN mkdir -p /home/app/extris

ADD . /home/app/extris

RUN apt-get -qq update 
RUN apt-get install -qq -y libsdl2-dev libsdl2-image-dev make git

WORKDIR /usr/include/
RUN ln -s /usr/lib/erlang/usr/include/erl_native_features_config.h
WORKDIR /home/app/extris
RUN mix deps.get

EXPOSE 4000
