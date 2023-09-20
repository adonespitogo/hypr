#!/bin/sh

icon_path="$HOME/.config/hypr/icons/video.png"
recordings="$HOME/Videos/Recordings"
tmp_dir="${recordings}/.tmp"
tmp_file="${tmp_dir}/.recording"

if [ -z $(pgrep wf-recorder) ]
then
    mkdir -p "${tmp_dir}"

    filename="${tmp_dir}/$(date "+%s").mp4"
    echo "$filename" > "${tmp_file}"

    wf-recorder --audio --file="${filename}" & disown && \
        notify-send -u low -i "${icon_path}" "Screen Record" "Recording has started." && \
        pkill -RTMIN+8 waybar
else
    notify-send -u low -i $icon_path "Screen Record" "Recording is already in progress."
fi
