#!/bin/sh

icon_path="$HOME/.config/hypr/icons/picture.png"

if [ ! -z $(pgrep wf-recorder) ];
then
    killall -s SIGINT wf-recorder
    while [ ! -z $(pgrep -x wf-recorder) ]; do wait; done
    pkill -RTMIN+8 waybar

    if [ -f "/tmp/.recording" ]; then
        filename="$(cat /tmp/.recording)"
        notify-send -u low -i "${icon_path}" "Screen Record" "Saved to ${filename}"
    fi
else
    notify-send "Not recording"
fi
