#!/bin/sh

icon_path="$HOME/.config/hypr/icons/video.png"
notify_cmd_shot="notify-send -h string:x-canonical-private-synchronous:screeenrecord -u low -i ${icon_path}"

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
        filename="Record_$(date "+%s").mp4"
        filepath="${recordings}/${filename}"
        saved_to="~/Videos/Recordings/${filename}"

        mv "${tmp_file}" "${filepath}"

        action=$($notify_cmd_shot "Screen Record" "Saved to ${saved_to}" --action " Open containing folder")

        if [[ "${action}" == "0" ]]; then
            thunar "${filepath}"
        fi
    fi
else
    ${notify_cmd_shot} "Screen Record" "Not recording!"
fi
