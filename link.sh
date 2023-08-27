#!/bin/bash

# This file is used for development purposes only.
# It will create symbolic links to your ~/.config directories to
# easily update the configs when editing files.

for DIR in alacritty hypr mako swappy swaylock waybar wlogout wofi
do

    src=$(pwd)/$DIR
    dst="$HOME/.config/$DIR"

    if [ ! -L ~/.config/$DIR ];then
        rm -rf $dst && \
            ln -s $src $dst && \
            echo "Linked $dst -> $src"
    else
        echo "Already a symbolic link: ~/.config/$DIR"
    fi

done
