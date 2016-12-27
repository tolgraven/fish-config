function docker_eval
	set -q docker_started
    and if test $docker_started = "true"
        eval (docker-machine env default)
        set -g docked_evaled
        #echo (set_color green)"DOCKER UP"(set_color normal)
        #sleep 3
        #and commandline -f repaint
    end
end
