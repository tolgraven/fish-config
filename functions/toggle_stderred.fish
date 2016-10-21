function toggle_stderred
	set -q DYLD_INSERT_LIBRARIES
    and set -gu DYLD_INSERT_LIBRARIES #i guess just want to turn it off temp for some programs so global unexport actually best option?
    #; and set -e stderred_on
    #or begin;
    #set stderred_on; set -Ux DYLD_INSERT_LIBRARIES "~/.local/lib/libstderred.dylib"
    #end
end
