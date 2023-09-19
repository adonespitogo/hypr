#!/bin/sh

icon_path="$HOME/.config/hypr/icons/picture.png"

if [ -z $(pgrep wf-recorder) ];
then
    recordings="$HOME/Videos/Recordings"
    mkdir -p "${recordings}"

    filename=$(zenity --entry --text "Screen record filename (no extension):")
    if [ -z "${filename}" ]; then exit; fi

    filename="${recordings}/${filename}_$(date "+%s").mp4"

    selection_area="$(slurp)"
    if [ -z $selection_area ];then exit;fi

    wf-recorder -g "${selection_area}" --audio --file="${filename}" >/dev/null 2>&1 &

    echo "$filename" > "/tmp/.recording"

    notify-send -u low -i "${icon_path}" "Screen Record" "Recording has started"
    # Restart waybar
    pkill -RTMIN+8 waybar
else
    notify-send "Recording already in progress"
fi
