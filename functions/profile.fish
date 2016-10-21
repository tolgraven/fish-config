function profile --description 'set/get iTerm profile' --argument profile force
	if test -z $argv[1] # echo curr profile
set -q itermprofile_current
and echo $itermprofile_current
or echo $ITERM_PROFILE
else if test $argv[1] = "reset" # reset profile
profile "$ITERM_PROFILE" forc
else
if test "$argv[1]" = "$itermprofile_current"
test -z $force
and return 1
or echo -n -e "\033]50;SetProfile=$argv\\a"
#echo $itermprofile_current #this was causing the mess w echoed back profiles
else if test $TERM_PROGRAM = "iTerm.app"
or not test -z $force
set -g itermprofile_prev (profile)
debug "switching from $itermprofile_prev"
echo -n -e "\033]50;SetProfile=$argv[1]\\a"
debug "switched to $argv[1]"
set -gx itermprofile_current $argv[1]
else
return 1
end
end
end
