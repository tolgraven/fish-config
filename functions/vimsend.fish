function vimsend --description 'send remote cmds to nvim instance via nvr' --argument session
nvr --servername=/tmp/nvimsocket$session (set -q argv[2]; and echo "$argv[2..-1]")
end
