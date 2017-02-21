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
  set -l stat $status
	if not isatty 1; or not status is-interactive 
		__fish_default_command_not_found_handler $argv; return
	end 

	tput cuu1
  commandline $argv #cmdline contents is passed in argv so works
	#check if can get pos 
	
	# history delete --exact --case-sensitive $cmdline #goes nuts for some reason

	# echo "type 'get' to search ALL YOUR PKGMANAGERS ALL OF THEM (current compatible nr: 0)"; echo hurharharhur
	##tput cup (string split " " $__tol_pos_preexec; or get_row)[1] (math $last_prompt_length + $last_commandline_pos)
end

#all handlers must be actively sourced at startup i guess...
function tol_sigint_handler --on-signal SIGINT -d "reset mucho stuff on ctrl-c" #argv is also SIGINT..
		not status is-interactive; and return

		get_row | read rowpos
		test "$rowpos" -eq "$LINES"; and set -l lastrow

		tput civis 
		commandline_save sigint; commandline "" #; commandline -f repaint

    tol_reload_key_bindings 								#restore key bindings
    while set -l index (contains -i %self $__tol_func_pid) #unset is-editing funcs
        set -Ue __tol_func_editing[$index]; set -Ue __tol_func_pid[$index]
    end
    profile reset 													#restore iterm profile
		echo -n (set -q lastrow; and echo)"Everything reset, UR CLEAN."
		# sleep 0.25; 
		# tput cuu 1
    tput rmcup 															#restore view
		# debug "row %s, cmdline %s, cmdpos %s, does work?" $rowpos $cmdline $cmdpos #not working in this func

		tput vpa $rowpos 												#restore row number (since rmcup jumps randomly)
    echo -n (tput cnorm) 										#restore cursor
		test -z "$lastrow"; 	and tput cuu1 		#except if restored pos is actually bottom row
		commandline_restore sigint
end

function __tol_fish_preexec --on-event fish_preexec
#   "TEST if a clear_lines variable is set, and clear that many lines beneath
#   like set that when doing commands that output below cursor, then can write temp info
#   that doesn't have to be instantly auto cleared while also not getting in the way of later commands
#   tput #OH PLUS if know curr line and know term size will know if output has caused scrolling so can adjust. tho lines is tricky with the wrapping and all... #wait don't actually have to count lines because won't be nothing else back there...
#  ### IMPORTANT IDEA!!! #keypress to eval a part of the commandline (a would-be subshell like), take result and replace expression in commandline with that
#  ### and one to do it with a whole line or piece of code as well. would be so massively easier to debug stuff then...
#     plus sub-idea, keypress to popup another readline prompt ontop of current one, to write an expression or modify the env or whatever... and any echoes there would also be propogated down into orig line if need be"
		# return
	not status is-interactive; and return

  # set -l cmd_time (time)
  # debug "commandline content: %s" $argv[1]
  # if set -q __tol_tempoutput_lines; end
  # get_pos | read -g __tol_pos_preexec
  # debug "preexec pos %s" $__tol_pos_preexec
  set -g last_commandline_pos (commandline -C);   set -g last_commandline_line_nr (commandline -L)
  debug "last commandline: %s  at pos: %s  at prompt-line %s" $last_commandline $last_commandline_pos $last_commandline_line_nr
end

function __tol_fish_postexec --on-event fish_postexec
	# return
	not status is-interactive; and return
	
  # get_pos | read -g __tol_pos_postexec
  debug "postexec pos %s" $__tol_pos_postexec
  # set -g last_commandline $argv[1]   #TODO: save pwd, stat, stdout/err like a parallel fish_history w more info, bring up in fzf hist.
end

function __tol_fish_prompt --on-event fish_prompt -d "event fish_prompt hook"
	# return

  # get_pos | read -g __tol_pos_preprompt
  debug "preprompt_pos pos %s" $__tol_pos_preprompt
end
