set -q fish_escape_delay_ms; 			or set -U fish_escape_delay_ms 		100
set -q fish_prompt_pwd_length; 		or set -U fish_prompt_pwd_length 	4
if contains $TERM_PROGRAM "iTerm.app"
	set -g fish_term24bit 						1
	set -g theme_nerd_fonts 					yes 		#only enable nerdfonts on box, not mobile etc
end
set -g theme_color_scheme 					gruvbox #share these with bobthefish since reusing their entire git thing
set -g theme_git_worktree_support 	yes
set -g theme_show_exit_status 			yes

set -q XDG_CONFIG_HOME;     or set -Ux XDG_CONFIG_HOME 		"$HOME/.config"
set -q XDG_DATA_HOME;       or set -Ux XDG_DATA_HOME   		"$HOME/.local/share"
set -q XDG_CACHE_HOME;      or set -Ux XDG_CACHE_HOME  		"$HOME/.cache"
set -x LC_ALL en_GB.UTF-8;  set -x LANG en_GB.UTF-8

set -q GITHUB_TOKEN; 				or set -Ux GITHUB_TOKEN 			"76cceb8c7cba52c92f2c41eaa8d113db7ddcdb46"
set -q GITHUB_USER; 				or set -Ux GITHUB_USER 				"tolgraven"
set -q HOMEBREW_GITHUB_API_TOKEN; or set -Ux HOMEBREW_GITHUB_API_TOKEN $GITHUB_TOKEN
set -q HOMEBREW_CASK_OPTS; 	or set -Ux HOMEBREW_CASK_OPTS "--appdir=/Applications"

set -q LESS_TERMCAP_mb; 		or configure_pager  					#funky colors. -U so only once per host
set -q LESS;            		or set -Ux LESS "--ignore-case --raw-control-chars --squeeze-blank-lines --status-column --tilde"

set -q FZF_DEFAULT_OPTS; 		or set -Ux FZF_DEFAULT_OPTS "--ansi --select-1 --exit-0 --inline-info --multi --sync \
--preview-window right:40:hidden --bind 'alt-p:toggle-preview' \
--color fg:-1,bg:-1,hl:65,fg+:3,bg+:233,hl+:69  --color info:150,prompt:110,spinner:150,pointer:167,marker:174"
set -q FZF_CTRL_T_OPTS; 		or set -Ux FZF_CTRL_T_OPTS \
"--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
set -q FZF_DEFAULT_COMMAND; or set -Ux FZF_DEFAULT_COMMAND 'ag --hidden -g ""'

set -eu OSTYPE; 						and set -Ux OSTYPE 						(uname) 	#stupid fisher plugs fucking eachother
set -q NODE_PATH;         	or set -Ux NODE_PATH  				"/usr/local/lib/node_modules"
set -q LNAV_EXP;          	or set -Ux LNAV_EXP  					"mouse"
set -q BYOBU_PREFIX;      	or set -Ux BYOBU_PREFIX 			(brew --prefix)
set -q TMUX_PLUGIN_MANAGER_PATH; or set -Ux TMUX_PLUGIN_MANAGER_PATH "$HOME/.config/tmux/plugins"
set -q GOOGLER_COLORS; 			or set set -Ux GOOGLER_COLORS "MEnhxI" #bBblue i, bblue titles, brpurple links, white text etc

set -q nfssettings;        	or set -U nfssettings \
"nolocks,locallocks,intr,soft,wsize=32768,rsize=32768,proto=tcp"
set -q rsyncopts;          	or set -U rsyncopts \
--human-readable --info=progress2 --recursive --times --perms --compress --links
set -q tolmenu_actions;    	or set -U tolmenu_actions \
'auto_desc' 'debug_on' 'debug_off' 'debug_token' 'debug_notoken'
set -q grc_wrap_commands;  	or set -U grc_wrap_commands \
cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff  #skip ls for tols, and cat for ccat/vimcat et al

switch (hostname)
	case absurd                      #eval (docker-machine env default ^&-) #)^ /dev/null)
		status --is-interactive; and source (rbenv init -|psub) 	#ruby rbenv
		set stderred_path ~/Documents/CODE/unix/stderred/build/libstderred.dylib 
		if set -q stderred_on #~/.local/lib/libstderred.dylib
			set -q STDERRED_BLACKLIST; 	or set -Ux STDERRED_BLACKLIST "fzf|lnav|htop|tmux|zsh|brew|go"
			contains $stderred_path $DYLD_INSERT_LIBRARIES; or set -Ux DYLD_INSERT_LIBRARIES $stderred_path $DYLD_INSERT_LIBRARIES
		else if contains "$stderred_path" "$DYLD_INSERT_LIBRARIES"; set -Ue DYLD_INSERT_LIBRARIES[ (contains -i "$stderred_path" "$DYLD_INSERT_LIBRARIES") ]
	end
end

test -f "/usr/local/share/autojump/autojump.fish"; and source "/usr/local/share/autojump/autojump.fish" #removed fisher fucker
test -z (which env_parallel.fish);  or source (which env_parallel.fish) #GNU parallel shell support
# type -q thefuck;                    and eval (thefuck --alias | tr '\n' ';') #fucking startup performance a bit?
#ulimit -n 65536 #is persistent and only set in osx
