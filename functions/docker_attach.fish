function docker_attach
	docker ps | grep -q $argv
    or docker start $argv
    itermprofileswitch "docker attach " "docker" $argv &
end
