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
  test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
end

#needs to have this name or we'd also have to delete the internal function
function __fish_command_not_found_handler --on-event fish_command_not_found 
  set -l stat $status;  set -l cmdline $argv #works!
	if not isatty 1; __fish_default_command_not_found_handler $argv; end 

	tput cuu1
	commandline "Command not found"; commandline -f repaint
	sleep 0.05; commandline -a "."; sleep 0.05; commandline -a "."; sleep 0.05; commandline -a "."
	sleep 0.05

	# echoerr -ns (set_color red) "Command not found" (set_color normal) "..."
  # sleep 0.2; tput cuu 1
	# echo "type 'get' to search ALL YOUR PKGMANAGERS ALL OF THEM (current compatible nr: 0)"; echo hurharharhur

  #tput cup (string split " " $__tol_pos_preexec; or get_row)[1] (math $last_prompt_length + $last_commandline_pos)
  commandline $cmdline #$last_commandline #wasnt working hmm guess it hasnt been saved yet at this point
  # commandline -C $last_commandline_pos; commandline -f repaint; return $stat
end

# function __tol_fish_preexec --on-event fish_preexec
  #"TEST if a clear_lines variable is set, and clear that many lines beneath
  #like set that when doing commands that output below cursor, then can write temp info
  #that doesn't have to be instantly auto cleared while also not getting in the way of later commands
  #tput #OH PLUS if know curr line and know term size will know if output has caused scrolling so can adjust. tho lines is tricky with the wrapping and all... #wait don't actually have to count lines because won't be nothing else back there...
 #### IMPORTANT IDEA!!! #keypress to eval a part of the commandline (a would-be subshell like), take result and replace expression in commandline with that
 #### and one to do it with a whole line or piece of code as well. would be so massively easier to debug stuff then...
 #    plus sub-idea, keypress to popup another readline prompt ontop of current one, to write an expression or modify the env or whatever... and any echoes there would also be propogated down into orig line if need be

  #set -l cmd_time (time)
  #debug "commandline content: %s" $argv[1]
#   if set -q __tol_tempoutput_lines; end
#   get_pos | read -g __tol_pos_preexec
#   debug "preexec pos %s" $__tol_pos_preexec
#   set -g last_commandline_pos (commandline -C);   set -g last_commandline_line_nr (commandline -L)
#   debug "last commandline: %s  at pos: %s  at prompt-line %s" $last_commandline $last_commandline_pos $last_commandline_line_nr
# end
#
# function __tol_fish_postexec --on-event fish_postexec
#   get_pos | read -g __tol_pos_postexec
#   debug "postexec pos %s" $__tol_pos_postexec
#   set -g last_commandline $argv[1]   #TODO: save pwd, stat, stdout/err like a parallel fish_history w more info, bring up in fzf hist.
# end
#
# function __tol_fish_prompt --on-event fish_prompt -d "event fish_prompt hook"
#   get_pos | read -g __tol_pos_preprompt
#   debug "preprompt_pos pos %s" $__tol_pos_preprompt
#   return 0
# end
