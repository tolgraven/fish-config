function setorset -a flags var values
	test (count $argv) -ge 3;  		or return 1
	if not set -q $var;  set $flags $var $argv[3..-1];  end
end

setorset -U fish_escape_delay_ms 		200
setorset -U fish_prompt_pwd_length 	4
if contains $TERM_PROGRAM "iTerm.app"; or test "$TMUX"; and set -q 24bit
	set -g fish_term24bit 						1
	set -g theme_nerd_fonts 					'yes' 		#only enable nerdfonts on box, not mobile etc
end
set -g theme_git_worktree_support 	'yes'
set -g theme_show_exit_status 			 'no' 		#'yes' #got my own
set -g theme_title_display_process 	'yes'
set -g theme_title_display_tty 			'yes' 		#tol custom

setorset -Ux TERM_ITALICS 				'true'

setorset -U tol_fish_abbr_file 	~/.config/fish/functions/../abbr.fish_defs
test (count (abbr -l)) -eq (count (command cat $tol_fish_abbr_file)); or source $tol_fish_abbr_file

setorset -Ux XDG_CONFIG_HOME 	"$HOME/.config"
setorset -Ux XDG_DATA_HOME   	"$HOME/.local/share"
setorset -Ux XDG_CACHE_HOME  	"$HOME/.cache"
#more xdg stuff...
# setorset -Ux CARGO_HOME				"$XDG_DATA_HOME"/cargo
# setorset -Ux ATOM_HOME				"$XDG_DATA_HOME"/atom
# setorset -Ux WGETRC						"$XDG_CONFIG_HOME/wgetrc"
setorset -Ux GNUPGHOME 				"$XDG_CONFIG_HOME/gnupg"
# set -q VIRTUALFISH_HOME; 		or set -Ux $VIRTUALFISH_HOME ~/.config/
setorset -Ux LESSHISTFILE 		"$XDG_CACHE_HOME/less/history"
setorset -Ux LESSKEY 					"$XDG_CONFIG_HOME/less/keys"
setorset -Ux MOST_INITFILE 		"$XDG_CONFIG_HOME/most/mostrc"
setorset -Ux TMUX_PLUGIN_MANAGER_PATH "$XDG_CONFIG_HOME/tmux/plugins"
setorset -Ux MPLAYER_HOME 		"$XDG_CONFIG_HOME/mplayer"
setorset -Ux SUBVERSION_HOME 	"$XDG_CONFIG_HOME/subversion"

setorset -Ux NVIM_PYTHON_LOG_FILE 	"$XDG_CACHE_HOME/nvim/nvim-python.log"

setorset -Ux NODE_PATH  			"/usr/local/lib/node_modules"

set -x LC_ALL en_GB.UTF-8;  set -x LANG 	en_GB.UTF-8

setorset -Ux GITHUB_TOKEN 		"282616fc76aeaa7360e07b4761749b1503611f0c"	#hub w repo acc, shouldnt actually be in here...
setorset -Ux GITHUB_USER 			"tolgraven"
setorset -Ux HOMEBREW_GITHUB_API_TOKEN 	$GITHUB_TOKEN
setorset -Ux HOMEBREW_CASK_OPTS 	"--appdir=/Applications"

set -q 			 LESS_TERMCAP_mb; 	or configure_pager 	#funky colors. -U in func so only once per host
setorset -Ux LESS 						"--ignore-case --raw-control-chars --squeeze-blank-lines --status-column --tilde -x4 -F"
# setorset -Ux PAGER "vimpager -s -c 'set nocursorline | set showtabline=1 | set nowrap'"
setorset -Ux PAGER 						"less"
setorset -Ux BROWSER 					'elinks'
type -q nvim; and set -x EDITOR 'nvim'; and set -x VISUAL 'nvim'


setorset -Ux FZF_DEFAULT_OPTS "--ansi --select-1 --exit-0 --inline-info --multi \
--preview-window right:40:hidden --bind 'alt-p:toggle-preview' \
--color fg:-1,bg:-1,hl:1,fg+:3,bg+:233,hl+:69  --color info:150,prompt:110,spinner:150,pointer:167,marker:174"
setorset -Ux FZF_CTRL_T_OPTS 	"--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
setorset -Ux FZF_DEFAULT_COMMAND 'ag --hidden -g ""'

set 		 -eu OSTYPE; 			and set -Ux OSTYPE 	(uname) 	#stupid fisher plugs fucking eachother
setorset -Ux LNAV_EXP  				"mouse"
setorset -Ux GOOGLER_COLORS 	"MEnhxI" #bBblue i, bblue titles, brpurple links, white text etc
# set -q RANGER_LOAD_DEFAULT_RC; or begin; test -f "$XDG_CONFIG_HOME/ranger/rc.conf"; and set -Ux RANGER_LOAD_DEFAULT_RC FALSE; end 	#down with this bc better get defaults loaded and thin down mine, so hectic otherwise
set 		 -gx RANGER_LOAD_DEFAULT_RC true

setorset -U  nfssettings 			"nolocks,locallocks,intr,soft,wsize=32768,rsize=32768,proto=tcp"
setorset -U  rsyncopts  			--human-readable --info=progress2 --recursive --times --perms --copy-links
setorset -U  tolmenu_actions 	'auto_desc' 'debug_on' 'debug_off' 'debug_token' 'debug_notoken' #argh lost old ones. needs to be name:action

setorset -U  grc_wrap_commands cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff blkid du dnf docker docker-machine env id ip iostat last lsattr lsblk lspci lsmod lsof getfacl getsebool ulimit uptime nmap fdisk findmnt free semanage sar ss sysctl systemctl stat showmount tune2fs tcpdump tune2fs vmstat w who  #skip ls for tols, and cat for ccat/vimcat et al
function _grc_wrap --argument cmd
	if set -q grc_wrap_commands
		not builtin contains -- "$cmd" $grc_wrap_commands; and return
	end
	function "$cmd" --inherit-variable cmd -w "$cmd"
		set -l options "grc_wrap_options_$cmd"
		command grc -es --colour=auto "$cmd" $$options $argv
	end
end; 	for cmd in $grc_wrap_commands; _grc_wrap $cmd; end

switch (hostname)
	case 'absurd*' 'NU*'
		set -g stderred_path 			~/.local/lib/libstderred.dylib 	#no check, so dont get outdated hanging aroudn if change
		setorset -Ux STDERRED_BLACKLIST "fzf|lnav|htop|tmux|zsh|brew|go|mosh|ssh|elinks|tldr|elinks"
        test -r $stderred_path; and __stderred startup
end
if status is-interactive 	#can I wrap all these?
	type -q autojump; and test -f (dirname (which autojump))/../share/autojump/autojump.fish; and source (dirname (which autojump))/../share/autojump/autojump.fish
	test -z (which env_parallel.fish);  or source (which env_parallel.fish)  #GNU parallel shell support. load on first invocation instead?
	source (rbenv init - | psub) 		#ruby rbenv
	eval (python -m virtualfish)		#python envs
	# eval (docker-machine env default ^&-) #)^ /dev/null) 	#docker envs
 	# test -n "$DESK_ENV"; and source "$DESK_ENV"; or true		# Hook for desk activation
    if not type -q fuck; and status is-interactive; eval (thefuck --alias)\n; funcsave fuck; end  #fucks shell startup by like 250ms when sourced on the fly, so save instead....
end

# XXX regular keybind recycling the f/t functionality from vim bindings! +prob vim-seek 2-char thing for good measure

# echo "setup colors..."
function __tol_setup_fish_colors -d "set all ze colors, bruvbox mode liek."
	set -U __tol_setup_fish_colors	 		 #only needs to be run once. unset to force changes
	
	set -U	fish_color_autosuggestion    d1d1d1
	set -U	fish_color_command           5f87ff
	set -U	fish_color_comment           afd7d7
	set -U	fish_color_cwd               ff981a
	set -U	fish_color_cwd_root          red
	set -U	fish_color_end               d78787
	set -U	fish_color_error             ff8a00
	set -U	fish_color_escape            --underline
	set -U	fish_color_history_current   cyan
	set -U	fish_color_host              cyan
	set -U	fish_color_match             green
	set -U	fish_color_normal            normal
	set -U	fish_color_operator          yellow
	set -U	fish_color_param             5fafd7
	set -U	fish_color_quote             d7d7ff
	set -U	fish_color_redirection       --bold --underline brpurple
	set -U	fish_color_search_match      --background=2850a5
	set -U	fish_color_selection         --bold --background=red
	set -U	fish_color_status            red
	set -U	fish_color_user              --bold green
	set -U	fish_color_valid_path        --bold --underline
	set -U	fish_pager_color_completion  grey
	set -U	fish_pager_color_description brpurple
	set -U	fish_pager_color_prefix      brblue
	set -U	fish_pager_color_progress    green
end
function __tol_setup_fish_dirs
	setorset -U fish_user_paths ~/.local/{bin,go/bin} /usr/local/sbin /usr/sbin
end
function __tol_setup_fish_emojis -d "set all ze emojis"
	set -U __tol_setup_fish_emojis	 		 #only needs to be run once. unset to force changes

	set -U e_check \u2755 \u2714 \u2753 \u274c \u2b55\ufe0f\u2b50\ufe0f\U0001f512 \U0001f513                                                                                                                                                                                                                                                                                                                                                                                                                              
	set -U e_clock_half \U0001f55c \U0001f55d \U0001f55e \U0001f55f \U0001f560 \U0001f561\U0001f562 \U0001f563 \U0001f564 \U0001f565 \U0001f566 \U0001f567                                                                                                                                                                                                                                                                                                                                                 
	set -U e_clock_whole \U0001f550 \U0001f551 \U0001f552 \U0001f553 \U0001f554 \U0001f555 \U0001f556 \U0001f557 \U0001f558 \U0001f559 \U0001f55a \U0001f55b                                                                                                                                                                                                                                                                                                                                            
	set -U e_folder \U0001f4c1 \U0001f4c2 \U0001f5c2 \U0001f4d5 \U0001f4d7 \U0001f4d8 \U0001f4d9 \U0001f4d4 \U0001f4d2                                                                                                                                                                                                                                                                                                                                                                                           
	set -U e_hands \U0001f4aa\U0001f3fc \U0001f448\U0001f3fc \U0001f449\U0001f3fc \u261d\ufe0f\U0001f3fc \U0001f446\U0001f3fc \U0001f595\U0001f3fc \U0001f447\U0001f3fc \u270c\ufe0f\U0001f3fc \U0001f596\U0001f3fc \U0001f918\U0001f3fc \U0001f590\U0001f3fc \u270a\U0001f3fc \u270b\U0001f3fc \U0001f44a\U0001f3fc \U0001f44c\U0001f3fc \U0001f44d\U0001f3fc \U0001f44e\U0001f3fc \U0001f44b\U0001f3fc \U0001f44f\U0001f3fc \U0001f450\U0001f3fc                              
	set -U e_moon \U0001f315 \U0001f316 \U0001f317 \U0001f318 \U0001f311                                                                                                                                                                                                                                                                                                                                                                                                                                                     
	set -U e_movement_right \U0001f680 \u2708\ufe0f \U0001f6e9 \U0001f6f0 \U0001f3f9 \u2604\ufe0f                                                                                                                                                                                                                                                                                                                                                                                                                         
	set -U e_sound \U0001f507 \U0001f50a \U0001f509 \U0001f508                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
	set -U e_tech \u231a \U0001f4bb \U0001f5a5 \U0001f4f1\u2328 \U0001f5b1 \U0001f3b9 \U0001f399 \U0001f39a                                                                                                                                                                                                                                                                                                                                                                                                         
	set -U e_time \u23f3 \u231b\ufe0f \u23f0 \U0001f4c6                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
	set -U e_util \U0001f5d1 \U0001f4be \U0001f4bd \U0001f50d \U0001f50e \U0001f526 \U0001f6a8 \U0001f3c1 \u2699 \U0001f4a1 \U0001f4e6                                                                                                                                                                                                                                                                                                                                                                     
	set -U e_weather \u2744\ufe0f \U0001f328 \U0001f4a8 \U0001f32a \U0001f32b\u2600\ufe0f \U0001f324 \u26c5\ufe0f \U0001f325 \U0001f326 \u2601\ufe0f \U0001f327 \u26c8 \U0001f329 \u26a1\ufe0f\U0001f4a7 \U0001f4a6                                                                                                                                                                                                                                                                            
	set -U emojis_nonshitty \U0001f4be \U0001f4bd \U0001f3b9 \U0001f6a8 \U0001f3c1 \U0001f680 \u231a \U0001f4bb \U0001f5b1 \U0001f5a5 \u2328 \U0001f4f1 \U0001f5d1 \U0001f50d \U0001f50e \U0001f3f4 \U0001f526 \u2714 \U0001f503 \u2795 \u2796 \u2797 \U0001f4b2 \U0001f553 \U0001f513 \U0001f512 \u2755 \u2753 \U0001f6ab \u274c \u2b55\ufe0f \u23f3 \u231b\ufe0f \U0001f507 \U0001f50a \U0001f509 \U0001f508 \U0001f578 
end
function __tol_setup_fish_stuff
	set -q __tol_setup_fish_colors; or __tol_setup_fish_colors
	set -q __tol_setup_fish_dirs; 	or __tol_setup_fish_dirs
	set -q __tol_setup_fish_emojis; or __tol_setup_fish_emojis

	# set -q __tol_setup_fish_glyphs; or __tol_setup_fish_glyphs
end
 __tol_setup_fish_stuff
function tol_reload_fish_stuff -d "run after changing colors and stuff like that"
	 set -e __tol_setup_fish_colors 
   set -e __tol_setup_fish_dirs 	
   set -e __tol_setup_fish_emojis 
end
setorset -U  __tols_folder_Blue				 \U0001f4d8
setorset -U  __tols_folder_Gray				 \U0001f4d3
setorset -U  __tols_folder_Green			 \U0001f4d7
setorset -U  __tols_folder_None				 \U0001f4c1
setorset -U  __tols_folder_Orange			 \U0001f4d9
setorset -U  __tols_folder_Purple			 \U0001f47e
setorset -U  __tols_folder_Red				 \U0001f4d5
setorset -U  __tols_folder_Yellow			 \U0001f4d4



# echo "init joen conf.d fish END"
# fish_config_file:/Users/tolgraven/.config/fish/config.fish                                                                                                                                                                                                                                                                                                                                                                                                                                                              
