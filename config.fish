set -q fish_path; or set -U fish_path $HOME/.config/fish/fisherman 
set -g fisher_path $fish_path #actually only fishers path, dumb name

if not contains $fish_function_path $fisher_path/functions
  set fish_function_path[1] $fisher_path/functions
  set fish_function_path $HOME/.config/fish/functions $fish_function_path
end
if not contains $fish_complete_path $fisher_path/completions
  set fish_complete_path[1] $fisher_path/completions
  set fish_complete_path $HOME/.config/fish/completions $fish_complete_path
end
for file in $fisher_path/conf.d/*.fish
	source $file
end

if not set -q iterm_integration_off
  test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish ^&-
end

#needs to have this name or we'd also have to delete the internal function
function __fish_command_not_found_handler --on-event fish_command_not_found 
  # set -l stat $status
	if not isatty 1; or not status is-interactive 
		__fish_default_command_not_found_handler $argv; return
	end 

	tput cuu1
  commandline $argv #cmdline contents is passed in argv so works
	#check if can get and restore crusor pos... 
	
	# history delete --exact --case-sensitive $cmdline #goes nuts for some reason

	# echo "type 'get' to search ALL YOUR PKGMANAGERS ALL OF THEM (current compatible nr: 0)"; echo hurharharhur
	##tput cup (string split " " $__tol_pos_preexec; or get_row)[1] (math $last_prompt_length + $last_commandline_pos)
end

#all handlers must be actively sourced at startup i guess...
function tol_sigint_handler --on-signal SIGINT -d "hella reset stuff on ctrl-c" #argv is just "SIGINT"..
		status is-interactive; or return

		get_line | read rowpos
		commandline --line | read cursorpos
		test "$rowpos" -eq "$LINES"; and set -l lastrow

		tput civis  																									#to avoid flicker
		commandline_save sigint; commandline ""

		#was gonna source config files as well but causes error for some reason?
    tol_reload_key_bindings 																			#restore key bindings
    while set -l index (contains -i %self $__tol_func_pid) 				#unset is-editing funcs
        set -Ue __tol_func_editing[$index]; set -Ue __tol_func_pid[$index]
    end
    profile reset 																								#restore iterm profile
		echo -n (tput rmcup) (tput vpa $rowpos)  											#reset smcup if any+line number in case not
		set -q lastrow; or tput cuu1 																	#up 1, except if were at bottom row
		echo -n "Everything reset, UR CLEAN."

		sleep 0.3
		tput cnorm

		commandline_restore sigint
		clear_below_cursor
end

function __tol_fish_preexec --on-event fish_preexec
#  if know curr line and know term size will know if output has caused scrolling so can adjust. tho lines is tricky with the wrapping and all... #wait don't actually have to count lines because won't be nothing else back there...
#  ### IMPORTANT IDEA!!! #keypress to eval a part of the commandline (a would-be subshell like), take result and replace expression in commandline with that
#  ### and one to do it with a whole line or piece of code as well. would be so massively easier to debug stuff then...
	status is-interactive; or return

  set -g last_commandline_pos (commandline -C);   set -g last_commandline_line_nr (commandline -L)
	set -g last_commandline $argv
  # debug "last commandline: %s  at pos: %s  at prompt-line %s" $last_commandline $last_commandline_pos $last_commandline_line_nr
end

function __tol_fish_postexec --on-event fish_postexec
	status is-interactive; or return
	
  # get_pos | read -g __tol_pos_postexec
  # debug "postexec pos %s" $__tol_pos_postexec
  # set -g last_commandline $argv[1]   #TODO: save pwd, stat, stdout/err like a parallel fish_history w more info, bring up in fzf hist.
end

function __tol_fish_prompt --on-event fish_prompt -d "event fish_prompt hook"
  # get_pos | read -g __tol_pos_preprompt
  # debug "preprompt_pos pos %s" $__tol_pos_preprompt
end
