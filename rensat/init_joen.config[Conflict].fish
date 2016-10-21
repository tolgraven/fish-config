set -q LESS_TERMCAP_mb; or configure_pager  # puts the funky colors. var -U so only needed once per host
set -q LESS;            or set -Ux LESS "--ignore-case --raw-control-chars --squeeze-blank-lines --status-column --tilde"

alias pa="pauseall";  alias pm="pausemusic";  alias pfm="pauseformusic"
alias ca="contall";   alias cm="contmusic";   alias cfm="contformusic"
alias p="prevd -l";   alias n="nextd -l"
alias nano="nano -m"
alias sle="cd /System/Library/Extensions/";   alias sleo="sle; o"
 
set grep_args '-i';             alias grep='grep --color=auto -i'
alias egrep='egrep $grep_args'; alias fgrep='fgrep $grep_args'  # ignore case

set -q grc_wrap_commands;  or set -U grc_wrap_commands cvs df diff dig gcc g++ \
ifconfig make mount mtr netstat ping ps tail traceroute wdiff  # skip ls for tols, and cat for ccat
set -q FZF_DEFAULT_OPTS;   or set -Ux FZF_DEFAULT_OPTS "--color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229 \
 --color info:150,prompt:110,spinner:150,pointer:167,marker:174 \
 --ansi --select-1 --exit-0 --inline-info --multi --sync"

set -q HOMEBREW_CASK_OPTS; or set -Ux HOMEBREW_CASK_OPTS "--appdir=/Applications" #"--caskdir=/usr/local/Caskroom"
set -q NODE_PATH;          or set -Ux NODE_PATH "/usr/local/lib/node_modules"
set -q LNAV_EXP;           or set -Ux LNAV_EXP "mouse"
set -q BYOBU_PREFIX;       or set -Ux BYOBU_PREFIX (brew --prefix)
set -q TMUX_PLUGIN_MANAGER_PATH; or set -Ux TMUX_PLUGIN_MANAGER_PATH $XDG_CONFIG_HOME/tmux/plugins/tpm

switch (hostname)
    case absurd;   eval (docker-machine env default ^ /dev/null)
      set -q STDERRED_BLACKLIST; or set -Ux STDERRED_BLACKLIST "fzf|lnav|htop|slmenu"
      set -q DYLD_INSERT_LIBRARIES; or set -Ux DYLD_INSERT_LIBRARIES /Users/tolgraven/Documents/CODE/unix/stderred/build/libstderred.dylib
end
contains $TERM_PROGRAM "iTerm.app"; and set fish_term24bit 1; or set fish_term24bit 0

test -z (which env_parallel.fish ^&-); or source (which env_parallel.fish) # GNU parallel
test -f /usr/local/share/autojump/autojump.fish; and source /usr/local/share/autojump/autojump.fish

set -q nfssettings; or set -U nfssettings "nolocks,locallocks,intr,soft,wsize=32768,rsize=32768,proto=tcp"

set -x LC_ALL en_US.UTF-8; set -x LANG en_US.UTF-8
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME ~/.config
set -q XDG_DATA_HOME;   or set -Ux XDG_DATA_HOME ~/.local/share
set -q XDG_CACHE_HOME;  or set -Ux XDG_CACHE_HOME ~/.cache

#ulimit -n 65536 #is persistent and only set in osx

function fish_command_not_found_handler --on-event fish_command_not_found #needs to have this name
  if not isatty 1; or not test (hostname) = "absurd"; echoerr "fish: command not found"; return; end
  
  tput cud1  
  echoerr -n -s (set_color red) "Command not found" (set_color normal) "..."
  sleep 0.1; commandline -f repaint
  tput cup (string split " " $__tol_pos_preexec; or get_row)[1] (math $last_prompt_length + $last_commandline_pos)

  commandline $last_commandline
  commandline -C $last_commandline_pos
  commandline -f repaint
end

function __tol_fish_preexec --on-event fish_preexec
  test (hostname) = "absurd"; or return 0 #set -l cmd_time (time)
  #debug "commandline content: %s" $argv[1]
  #"TEST if a clear_lines variable is set, and clear that many lines beneath
  #like set that when doing commands that output below cursor, then can write temp info
  #that doesn't have to be instantly auto cleared while also not getting in the way of later commands
  if set -q __tol_tempoutput_lines
    #tput #OH PLUS if know curr line and know term size will know if output has caused scrolling so can adjust. tho lines is tricky with the wrapping and all... #wait don't actually have to count lines because won't be nothing else back there...
  end
 #### IMPORTANT IDEA!!!
 #    keypress to eval a part of the commandline (a would-be subshell like), take result and replace expression in commandline with that
 #### and one to do it with a whole line or piece of code as well. would be so massively easier to debug stuff then...
 #    plus sub-idea, keypress to popup another readline prompt ontop of current one, to write an expression or modify the env or whatever... and any echoes there would also be propogated down into orig line if need be
 ####
  get_pos | read -g __tol_pos_preexec
  debug "preexec pos %s" $__tol_pos_preexec

  set -g last_commandline_pos (commandline -C)
  set -g last_commandline_line_nr (commandline -L)
  debug "last commandline: %s  at pos: %s  at prompt-line %s" $last_commandline $last_commandline_pos $last_commandline_line_nr
end

function __tol_fish_postexec --on-event fish_postexec
  test (hostname) = "absurd"; or return 0; get_pos | read -g __tol_pos_postexec
  debug "postexec pos %s" $__tol_pos_postexec
  set -g last_commandline $argv[1]
  #TODO: save pwd, exit status, output, outerr in like a parallel fish_history w more info. then bring up in fzf history viewer...
end

function __tol_fish_prompt --on-event fish_prompt -d "event fish_prompt hook"
  test (hostname) = "absurd"; or return 0; get_pos | read -g __tol_pos_preprompt
  debug "preprompt_pos pos %s" $__tol_pos_preprompt
  return 0
end
