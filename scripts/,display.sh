#!/bin/bash

all_displays=($(xrandr | grep " connected" | cut -f1 -d' '))
CURRENT_DISPLAY=$(xrandr | grep " connected primary" | cut -f1 -d' ')


DEFAULT_DISPLAY="eDP-1"
EXTERNAL_DISPLAY="HDMI-2"
echo "Connected displays: ${all_displays[*]}"
if [[ " ${all_displays[*]} " =~ "$EXTERNAL_VALUE" ]]; then
     echo "Switching from $DEFAULT_DISPLAY to $EXTERNAL_DISPLAY"
     xrandr --output $EXTERNAL_DISPLAY  --auto
     xrandr --output $DEFAULT_DISPLAY --off
fi

