#!/bin/bash

# This will remove the symbolic links created by links.sh and copy the new files to ~/.config

dir=$(pwd)

for DIR in alacritty hypr mako swappy swaylock waybar wlogout wofi
do
    src=$dir/$DIR
    dst=$HOME/.config/$DIR

    if test -L $dst;then
        cd ~/.config && rm $DIR && \
            cp -r $src $dst && \
            echo "Copied $src -> $dst"
    else
        cp -r $src $dst && \
            echo "Copied $src -> $dst"
    fi
done
