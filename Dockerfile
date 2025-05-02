FROM ubuntu:xenial

RUN apt update; apt install zsh tmux git curl make -y; 
RUN mkdir /root/dotfiles

COPY . /root/dotfiles
WORKDIR /root/dotfiles
