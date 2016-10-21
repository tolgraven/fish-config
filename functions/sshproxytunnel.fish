function sshproxytunnel --argument location port
	test -z $location
    and set location london
    test -z $port
    and set port 8080
    ssh -D $port knott@$location.tunnelr.com
end
