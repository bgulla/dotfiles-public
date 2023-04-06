FROM ubuntu:xenial
RUN apt update; apt install zsh tmux git make -y; 
RUN git clone https://git.hq2.lol/brandon/dotfiles.git 
