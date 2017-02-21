function profile --description 'set/get iTerm profile' --argument profile force
if test -z "$profile" # echo curr profile
set -q itermprofile_current
and echo $itermprofile_current
or echo $ITERM_PROFILE
else if test "$profile" = "reset" # reset profile
profile "$ITERM_PROFILE" forc
else
if test "$profile" = "$itermprofile_current"
if test -z "$force"
debug "bailing on %s"
return 1
end
echo -n -e "\033]50;SetProfile=$profile\\a"
debug "forcing %s" $profile

else if test "$TERM_PROGRAM" = "iTerm.app"
or not test -z "$force"
set -g itermprofile_prev (profile)
echo -n -e "\033]50;SetProfile=$profile\\a"
set -gx itermprofile_current $profile
debug "switching from $itermprofile_prev to $profile"
else
debug "switch not handled %s" $profile
echo -n -e "\033]50;SetProfile=$profile\\a"
return 1
end
end
end
