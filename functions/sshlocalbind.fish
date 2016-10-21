function sshlocalbind
	autossh -M 0 -o "ServerAliveInterval 10" -o ExitOnForwardFailure=yes -f -v knott@stockholm.tunnelr.com -L 5023:localhost:5022 -N
end
