function docker_startit
	docker-machine start
    #emit DOCKER_MACHINE_UP
    set -q docker_started
    and set -e docker_started
    set -U docker_started true
    #docker_eval
    #eval (docker-machine env default)
end
