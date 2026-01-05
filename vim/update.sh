#!/bin/bash

echo -e "Cloning repo"
cd ~/Downloads
git clone https://github.com/vim/vim
cd vim 
./configure --with-features=huge \
            --enable-multibyte \
            --disable-gui \
            --enable-python3interp \
            --with-python3-config-dir=$(python3-config --configdir) \
            --with-python3-command=/usr/bin/python3 \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-cscope \
            --prefix=/usr/local
make -j4
sudo make install
rm -rf ../vim
