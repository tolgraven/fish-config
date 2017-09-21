function fork_trace
set -l printargs '"\t%s\t%d\t%d",execname,pid,ppid'
sudo dtrace -n "syscall::fork*:entry{printf($printargs);}"
end
