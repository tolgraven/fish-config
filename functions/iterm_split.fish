function iterm_split
osascript -e 'tell application "iTerm2"
  tell current session of current window
    split horizontally with same profile
  end tell
end tell'
#    split horizontally with profile "standard" command "/usr/local/bin/fish -c \"$argv\""
end
