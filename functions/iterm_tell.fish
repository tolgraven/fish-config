function iterm_tell
osascript -e "tell application \"iTerm2\"
    $argv
end tell"
end
