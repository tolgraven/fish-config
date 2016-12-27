function itermprofileswitch --description 'switch to profile, run cmd, switch back' --argument cmd cmdprofile passedargv
	test -z "$cmd"
    and return 1

    set -q itermprofile_current
    and set -gx itermprofile_on_return $itermprofile_current
    or set -gx itermprofile_on_return $ITERM_PROFILE
    debug "profile for return: %s \n profile for cmd: %s \n command: %s" $itermprofile_on_return $cmdprofile $cmd
    itermprofileswitch_logos $itermprofile_on_return $cmdprofile
    profile $cmdprofile

    eval $cmd $passedargv (test (count $argv) -gt 3; and echo $argv[4..-1])
    set stat $status
    itermprofile_cleanup

    return $stat
end
