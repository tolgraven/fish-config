function pssh
	psc ssh command | grep -v iTerm2 | string replace "/usr/bin/" "" | string replace "ServerAliveInterval" "SeAlIn" | string replace "ExitOnForwardFailure" "ExOnFoFa" #| string replace "/Applications/iTerm.app/Contents/MacOS/iTerm2" "iTerm2"
end
