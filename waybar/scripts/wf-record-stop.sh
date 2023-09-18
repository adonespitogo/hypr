#!/bin/sh

if [ ! -z $(pgrep wf-recorder) ];
then
    killall -s SIGINT wf-recorder
    while [ ! -z $(pgrep -x wf-recorder) ]; do wait; done
    pkill -RTMIN+8 waybar
    notify-send "Recording complete"
else
    notify-send "Not recording"
fi
