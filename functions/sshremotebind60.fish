function sshremotebind60
	autossh -M 0 -o "ServerAliveInterval 10" -o ExitOnForwardFailure=yes -f -v -R localhost:6022:localhost:22 knott@stockholm.tunnelr.com -N
end
