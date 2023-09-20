#!/bin/sh

icon_path="$HOME/.config/hypr/icons/video.png"
recordings="$HOME/Videos/Recordings"
tmp_dir="${recordings}/.tmp"
tmp_file="${tmp_dir}/.recording"

if [ ! -z $(pgrep wf-recorder) ];
then
    killall -s SIGINT wf-recorder
    while [ ! -z $(pgrep -x wf-recorder) ]; do wait; done
    pkill -RTMIN+8 waybar

    if [ -f "${tmp_file}" ]; then
        tmp_file="$(cat $tmp_file)"
        filename="Record_$(date "+%s")"
        filename="${recordings}/${filename}.mp4"

        mv "${tmp_file}" "${filename}"

        action=$(notify-send -u low -i "${icon_path}" "Screen Record" "Saved to ${filename}" --action "Locate")

        if [[ "${action}" == "0" ]]; then
            thunar "${filename}"
        fi
    fi
else
    notify-send -i $icon_path -u low "Screen Record" "Not recording!"
fi
