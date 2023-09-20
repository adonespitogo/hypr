#!/bin/sh

icon_path="$HOME/.config/hypr/icons/video.png"

if [ ! -z $(pgrep wf-recorder) ];
then
    killall -s SIGINT wf-recorder
    while [ ! -z $(pgrep -x wf-recorder) ]; do wait; done
    pkill -RTMIN+8 waybar

    if [ -f "/tmp/.recording" ]; then
        filename="$(cat /tmp/.recording)"
        action=$(notify-send -u low -i "${icon_path}" "Screen Record" "Saved to ${filename}" --action "Locate")

        if [[ "${action}" == "0" ]]; then
            thunar "${filename}"
        fi
    fi
else
    notify-send -u low "Screen Record" "Not recording!"
fi
