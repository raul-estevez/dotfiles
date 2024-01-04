#!/bin/bash

echo -e "Installing dependencies:"

sudo apt install libncurses5-dev libgtk2.0-dev libatk1.0-dev \
libcairo2-dev libx11-dev libxpm-dev libxt-dev \
python3-dev lua5.2 liblua5.2-dev libperl-dev git

echo -e "Cloning repo"
cd ~/Downloads
git clone https://github.com/vim/vim
cd vim 
./configure --with-features=huge \
            --enable-multibyte \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-cscope \
            --prefix=/usr/local
make
sudo make install
