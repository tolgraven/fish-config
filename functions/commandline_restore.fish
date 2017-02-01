function commandline_restore --description 'restore saved commandline' --argument register
if set -q __tol_commandline_content"$register"
debug "current: cursor %s, len %s, line %s, count %s, content %s" (commandline --cursor) (string length -- (commandline)) (commandline --line) (count (commandline)) (commandline)

#for some reason need to redirect output or this also echoes out...
commandline $__tol_commandline_content$register >&- ^&-
commandline --cursor $__tol_commandline_cursor$register >&- ^&-

debug "restoring: register %s, cursor %s, len %s, line %s, count %s, content %s" "$register" $__tol_commandline_cursor$register $__tol_commandline_length$register $__tol_commandline_line$register $__tol_commandline_line_count$register "$__tol_commandline_content$register"
end
commandline -f repaint
end
