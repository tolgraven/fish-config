#/usr/bin/env bash
# Author: Sina Siadat (2015)
set -e
browser_name="Google Chrome"
browser_cli="chrome-cli"
err=

# Check requirements
hash chrome-cli 2> /dev/null ; if [ $? -eq 1 ]; then
  err=1
fi

hash fzf 2> /dev/null ; if [ $? -eq 1 ]; then
  err=1
fi

if [ "$err" = "1" ]; then
  echo >&2 "error:  This script uses chrome-cli and fzf."
  echo >&2 "error:  chrome-cli is a OSX tool. Send a patch"
  echo >&2 "error:  if you have a Linux alternative!"
  echo >&2 "error:"
  echo >&2 "error:  Install dependencies using Homebrew:"
  echo >&2 "error:    brew install chrome-cli fzf"
  exit 1
fi

# Select a tab
tabid=$( chrome-cli list tabs | fzf -1 --prompt="Tab name> " | grep -Eo '^.\d+.' |grep -Eo '\d+' )
if [ "$tabid" = "" ]; then
  exit 0
fi

# Activate tab
$browser_cli activate -t $tabid

# Bring window to front (OSX)
hash osascript 2> /dev/null ; if [ $? -eq 0 ]; then
  osascript -e "tell application \"${browser_name}\" to activate"
  exit 0
fi

# Bring window to front (X11 wmctrl)
# NOTE: this is not tested
hash wmctrl  2> /dev/null ; if [ $? -eq 0 ]; then
  wmctrl -a "${browser_name}"
  exit 0
fi

# Bring window to front (X11 xdotool)
# NOTE: this is not tested
hash xdotool  2> /dev/null ; if [ $? -eq 0 ]; then
  xdotool search --class "${browser_name}" windowactivate
  exit 0
fi

# TODO i3 wm
# TODO xmonad
