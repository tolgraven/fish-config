function jobs_kill --description 'kill all the jobs'
	echo (set_color --background brblue) "Initial jobs:" (set_color normal) (set_color green)
    jobs
    set_color brgreen
    for job in (jobs -p)
        kill $job
    end
    echo (set_color --background brred) "Surviving jobs:" (set_color normal) (set_color bryellow)
    spin "sleep 1"
    jobs
    set_color yellow
    for job in (jobs -p)
        kill -9 $job
    end
    echo (set_color --background red) "Post -9:" (set_color normal) (set_color yellow)
    spin "sleep 1"
    jobs
end
