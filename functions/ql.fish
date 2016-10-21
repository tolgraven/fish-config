function ql --description 'Quick Look a specified file or directory'
	if [ (count $argv) -gt 0 ]
        qlmanage >/dev/null ^/dev/null -p $argv &
    else if not test -z (pbpaste)
        and test -e (pbpaste)
        qlmanage -p (pbpaste) ^&- >&- &
    else
        echo "No arguments given"
    end
end
