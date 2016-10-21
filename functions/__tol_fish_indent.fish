function __tol_fish_indent --description 'indent and highlight currenct command using fish_indent'
	set -l pipe '|'
    set -l cmd 'fish_indent'
    set -l opt '--ansi'
    contains -- (string split "" (string trim (commandline))[-1] ) "|"
    and set pipe ''
    if commandline -j | string match -q -r -v "$cmd *\$"
        commandline -aj "$pipe $cmd $opt"
    end
end
