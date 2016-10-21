function iterm_tell_session
	osascript -e "tell application 'iTerm2'
  tell current session of current window
    $argv
  end tell
end tell"
end
