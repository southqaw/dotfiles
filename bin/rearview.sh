#!/usr/bin/env bash

exec > /dev/null
exec 2>&1

mplayer -geometry 160x120+1+746 -tv driver=v4l2:device=/dev/video0 tv://
