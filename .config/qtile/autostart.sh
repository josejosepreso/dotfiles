#!/usr/bin/sh

xrandr --output eDP1 --primary --mode 1366x768 --rotate normal --output HDMI2 --auto --rotate normal --right-of eDP1
xrandr --output HDMI2 --brightness 0.55
~/.fehbg
xrdb ~/.Xresources
