function odrive-agent
	#security unlock-keychain #just needed first time or every? is when ssh in...
    ~/.odrive-agent/bin/odriveagent.app/Contents/MacOS/odriveagent >/dev/null &
    #nohup "$HOME/.odrive-agent/bin/odriveagent.app/Contents/MacOS/odriveagent" >/dev/null &
end
