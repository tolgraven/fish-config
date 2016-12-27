function cpulimit --description 'usage: cpulimit [program] [maxcpu]' --argument program maxcpu
	# FISH CANT BACKGROUND ITS OWN CODE UGH
    set -l target (string split --right --max=1 -- ' ' (ps axo time,ucomm,pid | grep "$program" | sort)[-1])[-1]
    sudo cpulimit -z -i --limit=$maxcpu --pid=$target #(pgrep $program)[1] #&
    #fg
    #bg # only grabs first pid, maybe switch so can also loop and limit all hits, but not needed for iterm2

    #command cpulimit -l $argv[2] -p (pgrep $argv[1])
end
