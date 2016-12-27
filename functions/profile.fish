function profile --description 'set/get iTerm profile' --argument profile force
	if test -z "$profile" # echo curr profile
        set -q itermprofile_current
        and echo $itermprofile_current
        or echo $ITERM_PROFILE
    else if test "$profile" = "reset" # reset profile
        profile "$ITERM_PROFILE" forc
    else
        if test "$profile" = "$itermprofile_current"
            test -z "$force"
            and debug "bailing on %s" $profile
            and return 1
            or echo -n -e "\033]50;SetProfile=$profile\\a"
            debug "forcing %s" $profile
            #echo $itermprofile_current #this was causing the mess w echoed back profiles
        else if test $TERM_PROGRAM = "iTerm.app"
            or not test -z "$force"
            set -g itermprofile_prev (profile)
            debug "switching from $itermprofile_prev"
            echo -n -e "\033]50;SetProfile=$profile\\a"
            debug "switched to $argv[1]"
            set -gx itermprofile_current $profile
        else
            debug "switch not handled %s" $profile
            return 1
        end
    end
end
