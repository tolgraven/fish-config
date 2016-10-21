set -g docker_machine_args "active  Print active machine
config  Print conn cfg for machine
create  Create a machine
env  Echo cmds to set up Docker env
inspect  Inspect info about machine
ip  Get IP address of machine
kill  Kill a machine
ls  List machines
provision  Re-provision machines
regenerate-certs  Regenerate TLS Certs
restart  Restart a machine
rm  Remove a machine
ssh  Log in or run cmd with SSH
scp  Copy files between machines
start  Start a machine
status  Get status of machine
stop  Stop a machine
upgrade  Upgrade machine to latest Docker
url  Get URL of machine
version  Show DM ver or a machines docker v
help  ls cmds or help for a cmd"

complete -xc docker-machine -a '(for line in (echo -n $docker_machine_args\n); set parts (string split "  " $line); echo -s $parts[1] \t $parts[2]; end)'
# complete -xc docker-machine -a '(echo (string split " " $docker_machine_args) )'
