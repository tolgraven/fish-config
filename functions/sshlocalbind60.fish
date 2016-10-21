function sshlocalbind60
	autossh -M 0 -o "ServerAliveInterval 10" -o ExitOnForwardFailure=yes -f -v knott@stockholm.tunnelr.com -L 6023:localhost:6022 -N
end
