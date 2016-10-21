function rdplocalbind
	autossh -M 0 -o "ServerAliveInterval 10" -o ExitOnForwardFailure=yes -f -v knott@stockholm.tunnelr.com -L 3389:localhost:33389 -N
end
