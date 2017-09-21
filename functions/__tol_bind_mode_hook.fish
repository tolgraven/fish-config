function __tol_bind_mode_hook --on-variable fish_bind_mode
#find other way to get called every keypress. doesnt seem to work the same any more
set -q tol_auto_describe
and __tol_desc_token

#not commandline --paging-mode
#and commandline -f complete
#debug "uh-huh"
#echo \nWHAAA\n
end
