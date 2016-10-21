function funcrm --description 'remove saved function' --argument function
	test -z $function #heh #CMON FUCKING SAVE FFS
    and echoerr "no function specified"
    and return 1
    set -l funcdir ~/.config/fish/functions
    set -l funcfile $funcdir/$function.fish
    if test -f $funcfile
        type -q trash
        and trash $funcfile
        or mv $funcfile $funcdir/$function.BAK_fish

        functions -e $function

        echo function $function "erased in-memory and from autoloading function dir"
    else
        echoerr function $function "not in user function dir, nothing done"
        return 1
    end
end
