#!/bin/sh

xgamma -rgamma 0.9 -ggamma 0.9
picom -b
dunst &
blueman-applet &
lxsession &
