function resign --description 'Replace codesign with generic, if syslog is throwing a fit'
	sudo codesign -f -s - $argv
end
