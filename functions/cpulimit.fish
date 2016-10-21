function cpulimit --description 'usage: cpulimit [program] [maxcpu]' --argument program maxcpu
	# FISH CANT BACKGROUND ITS OWN CODE UGH
sudo command cpulimit -z -i --limit=$maxcpu --pid=(pgrep $program)[1] &
bg # only grabs first pid, maybe switch so can also loop and limit all hits, but not needed for iterm2

#command cpulimit -l $argv[2] -p (pgrep $argv[1])
end
