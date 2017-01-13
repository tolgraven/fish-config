function chrome-cli_new_window
    chrome-cli open www.google.com -n
    sleep 0.2
    chrome-cli position 0 0
    osascript -e "tell application \"Google Chrome\" to activate"
end
