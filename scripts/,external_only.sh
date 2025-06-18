#!/bin/bash

autorandr horizontal

# Detect external monitor name automatically
EXTERNAL=$(xrandr | grep " connected" | grep -v eDP | cut -d" " -f1)
INTERNAL=$(xrandr | grep " connected" | grep eDP | cut -d" " -f1)

# Turn off internal and turn on external
xrandr --output "$INTERNAL" --off --output "$EXTERNAL" --auto
