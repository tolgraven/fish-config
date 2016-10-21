function tv4
	#autossh -M 0 -o "ServerAliveInterval 10" -o ExitOnForwardFailure=yes -f -v knott@stockholm.tunnelr.com -L 5023:localhost:5022 -N
    itermprofileswitch "ssh $argv -p 5023 joen.tolgraven@localhost" TV4
end
