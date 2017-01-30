function commandline_save --description 'save contents and cursor position of commandline, to restore later' --argument register
set -g __tol_commandline_content"$register" (commandline)

set -g __tol_commandline_cursor"$register" (commandline --cursor)
set -g __tol_commandline_length"$register" (string length -- $__tol_commandline_content)
set -g __tol_commandline_line"$register" (commandline --line)
set -g __tol_commandline_line_count"$register" (count $__tol_commandline_content)

debug "register %s, cursor %s, len %s, line %s, count %s, content %s" "$register" $__tol_commandline_cursor$register $__tol_commandline_length$register $__tol_commandline_line$register $__tol_commandline_line_count$register "$__tol_commandline_content$register"
end
