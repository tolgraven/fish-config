function __tol_tldr_token
	set val (eval echo (commandline -t))
    if type -q $val
        set tldr (tldr $val)
        not test $tldr[1] = "This page doesn't exist yet!"
        and printf "\n"
        and tldr $val
        commandline -f repaint
    end
end
