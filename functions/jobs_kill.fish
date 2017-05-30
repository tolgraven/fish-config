function jobs_kill --description 'kill all the jobs'
echo (set_color --background brblue black) "Initial   " (set_color normal) (set_color green)
jobs
set_color brgreen
for job in (jobs -p)
kill $job
end
echo (set_color --background brred black) "Surviving " (set_color normal) (set_color bryellow)
spin "sleep 1"
jobs
set_color yellow
for job in (jobs -p)
kill -9 $job
end
echo (set_color --background red black) "Post -9   " (set_color normal) (set_color yellow)
spin "sleep 0.3"
jobs
end
