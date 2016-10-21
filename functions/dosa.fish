function dosa
	docker start $argv
    and itermprofileswitch "docker attach $argv" docker
end
