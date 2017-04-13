function __stderred -a trigger -d "toggle stderred on var stderred" --on-variable stderred
	test "$trigger" != "startup"; and echoerr "switching stderred"
	if set -q stderred
		debug "inserting stderred into DYLD_INSERT_LIBRARIES"
		contains "$stderred_path" $DYLD_INSERT_LIBRARIES; and return

		if set -Uq stderred; 			set setter 'set -Ux'
		else if set -gq stderred; set setter 'set -gx'
		else if set -lq stderred; set setter 'set -lx'
		end
		set -lq setter
		and eval "$setter" DYLD_INSERT_LIBRARIES $stderred_path $DYLD_INSERT_LIBRARIES

	else
		while set index (contains -i "$stderred_path" $DYLD_INSERT_LIBRARIES)
			debug "nuking stderred from DYLD_INSERT_LIBRARIES..."
			set -e DYLD_INSERT_LIBRARIES[$index] 
		end
	end

	# change below to like "post message for prompt" instead...
	test "$trigger" != "startup"; and echoerr "switched stderred"
	commandline -f repaint
end
