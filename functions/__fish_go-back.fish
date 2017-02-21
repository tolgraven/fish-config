function __fish_go-back
if commandline --search-mode
return
end

set -l cmd (commandline -po)
if count $cmd >/dev/null
if test "$cmd[1]" = "go-back"
commandline -f execute
if commandline --paging-mode
commandline -f execute
end
end
return
end

set -l dirhist (go-back)
if test -n "$dirhist"
#commandline -r " go-back "
#commandline -f complete down-line
go-back (complete -C'go-back ')
return
end

# printf "<directory history is empty>"
# printf "\n%.0s" (fish_prompt)
# commandline -f repaint
end
