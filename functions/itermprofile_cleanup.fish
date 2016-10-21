function itermprofile_cleanup
	# FUCK YOU GOOGLE SYNC THIS FILE!!!
    #set -q itermprofile_on_return
    set -l from $itermprofile_current
    set -l to $itermprofile_on_return
    debug "from is $from"
    debug "to is $to"
    if not test -z $itermprofile_on_return
        itermprofileswitch_logos $from $to
        profile $itermprofile_on_return
        and set -e itermprofile_on_return
    end
end
