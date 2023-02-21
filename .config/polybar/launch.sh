#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# modules
killall -q vpn
killall -q loadavg
killall -q battery
killall -q datetime
killall -q torrent

# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# https://github.com/polybar/polybar/wiki#dealing-with-xrandr-15-randomized-monitor-names
MONITOR=$(polybar -m|tail -1|sed -e 's/:.*$//g')

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log
#polybar "$@" >> /tmp/polybar1.log 2>&1 &
MONITOR="${MONITOR:-"eDP-1"}" polybar "$@" >> /tmp/polybar1.log 2>&1 &

# echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# polybar bar1 >>/tmp/polybar1.log 2>&1 &
# polybar bar2 >>/tmp/polybar2.log 2>&1 &

echo "Bars launched..."
