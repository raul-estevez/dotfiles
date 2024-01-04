#!/bin/bash

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
