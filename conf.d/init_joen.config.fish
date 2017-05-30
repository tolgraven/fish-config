function setorset -a flags var values
	test (count $argv) -ge 3;  or return 1
	if not set -q $var;  set $flags $var $argv[3..-1];  end
end

setorset -U fish_escape_delay_ms 		200
setorset -U fish_prompt_pwd_length 	4
if contains $TERM_PROGRAM "iTerm.app"; or test "$TMUX"; and set -q 24bit
	set -g fish_term24bit 						1
	set -g theme_nerd_fonts 					'yes' 		#only enable nerdfonts on box, not mobile etc
end
set -g theme_color_scheme 					'gruvbox' #share these with bobthefish since reusing their entire git thing
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
#export ATOM_HOME="$XDG_DATA_HOME"/atom
#export CARGO_HOME="$XDG_DATA_HOME"/cargo
#$ mkdir -p "$XDG_CACHE_HOME"/less
# export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
# export LESSHISTFILE=- can be used to disable this feature.
# export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
#export WGETRC="$XDG_CONFIG_HOME/wgetrc"

set -x GNUPGHOME 							"$XDG_CONFIG_HOME/gnupg"
set -x MPLAYER_HOME 					"$XDG_CONFIG_HOME/mplayer"
set -x SUBVERSION_HOME 				"$XDG_CONFIG_HOME/subversion"
# set -q VIRTUALFISH_HOME; 		or set -Ux $VIRTUALFISH_HOME ~/.config/

set -x LC_ALL 	en_GB.UTF-8;  set -x LANG 	en_GB.UTF-8

setorset -Ux GITHUB_TOKEN 		"76cceb8c7cba52c92f2c41eaa8d113db7ddcdb46"
setorset -Ux GITHUB_USER 			"tolgraven"
setorset -Ux HOMEBREW_GITHUB_API_TOKEN 	$GITHUB_TOKEN
setorset -Ux HOMEBREW_CASK_OPTS 	"--appdir=/Applications"
# setorset -Ux BREW_CACHE 			/Volumes/SO-FUNKY/Users/tolgraven/Library/Caches/Homebrew #nah, just move and symlink..

set -q 			 LESS_TERMCAP_mb; 	or configure_pager 	#funky colors. -U in func so only once per host
setorset -Ux LESS 						"--ignore-case --raw-control-chars --squeeze-blank-lines --status-column --tilde -x4 -F"
set 		 -x  LESSHISTFILE 		"$XDG_CONFIG_HOME/less/history"; set -x LESSKEY "$XDG_CONFIG_HOME/less/keys"
setorset -Ux MOST_INITFILE 		"$XDG_CONFIG_HOME/most/mostrc"
# setorset -Ux PAGER "vimpager -s -c 'set nocursorline | set showtabline=1 | set nowrap'"
setorset -Ux PAGER 						"less"
setorset -Ux BROWSER 					'elinks'
type -q nvim; and setorset -Ux EDITOR 	'nvim'

set 		 -gx NVIM_TUI_ENABLE_CURSOR_SHAPE 	1
set 		 -gx NVIM_TUI_ENABLE_TRUE_COLOR 		1
setorset -Ux NVIM_PYTHON_LOG_FILE 	"$XDG_CACHE_HOME/neovim/nvim-python.log"

setorset -Ux FZF_DEFAULT_OPTS "--ansi --select-1 --exit-0 --inline-info --multi \
--preview-window right:40:hidden --bind 'alt-p:toggle-preview' \
--color fg:-1,bg:-1,hl:1,fg+:3,bg+:233,hl+:69  --color info:150,prompt:110,spinner:150,pointer:167,marker:174"
setorset -Ux FZF_CTRL_T_OPTS 	"--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
setorset -Ux FZF_DEFAULT_COMMAND 'ag --hidden -g ""'

set 		 -eu OSTYPE; 			and set -Ux OSTYPE 	(uname) 	#stupid fisher plugs fucking eachother
setorset -Ux NODE_PATH  			"/usr/local/lib/node_modules"
setorset -Ux LNAV_EXP  				"mouse"
setorset -Ux TMUX_PLUGIN_MANAGER_PATH "$XDG_CONFIG_HOME/tmux/plugins"
setorset -Ux GOOGLER_COLORS 	"MEnhxI" #bBblue i, bblue titles, brpurple links, white text etc
# set -q RANGER_LOAD_DEFAULT_RC; or begin; test -f "$XDG_CONFIG_HOME/ranger/rc.conf"; and set -Ux RANGER_LOAD_DEFAULT_RC FALSE; end 	#down with this bc better get defaults loaded and thin down mine, so hectic otherwise
set 		 -gx RANGER_LOAD_DEFAULT_RC true

setorset -U  nfssettings 			"nolocks,locallocks,intr,soft,wsize=32768,rsize=32768,proto=tcp"
setorset -U  rsyncopts  			--human-readable --info=progress2 --recursive --times --perms --copy-links
setorset -U  tolmenu_actions 	'auto_desc' 'debug_on' 'debug_off' 'debug_token' 'debug_notoken' #argh lost old ones. needs to be name:action

# setorset -U  grc_wrap_commands cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff  #skip ls for tols, and cat for ccat/vimcat et al
setorset -U  grc_wrap_commands cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff blkid du dnf docker docker-machine env id ip iostat last lsattr lsblk lspci lsmod lsof getfacl getsebool ulimit uptime nmap fdisk findmnt free semanage sar ss sysctl systemctl stat showmount tune2fs tcpdump tune2fs vmstat w who
function _grc_wrap --argument cmd
	if set -q grc_wrap_commands
		not builtin contains -- "$cmd" $grc_wrap_commands; and return
	end
	function "$cmd" --inherit-variable cmd -w "$cmd"
		set -l options "grc_wrap_options_$cmd"
		command grc -es --colour=auto "$cmd" $$options $argv
	end
end; 		for cmd in $grc_wrap_commands; _grc_wrap $cmd; end


switch (hostname)
	case absurd
		set -g stderred_path 			~/.local/lib/libstderred.dylib 	#no check, so dont get outdated hanging aroudn if change
		setorset -Ux STDERRED_BLACKLIST "fzf|lnav|htop|tmux|zsh|brew|go|mosh|ssh"
		__stderred startup
end
if status is-interactive 	#can I wrap all these?
	type -q autojump; and test -f (dirname (which autojump))/../share/autojump/autojump.fish; and source (dirname (which autojump))/../share/autojump/autojump.fish #more generic like
	source (rbenv init - | psub) 	#ruby rbenv
	test -z (which env_parallel.fish);  or source (which env_parallel.fish) #GNU parallel shell support
	eval (python -m virtualfish)
	# eval (docker-machine env default ^&-) #)^ /dev/null)
# test -n "$DESK_ENV"; and source "$DESK_ENV"; or true
	# type -q thefuck; and status is-interactive; and eval (thefuck --alias | tr '\n' ';') #fucking startup performance a fuckton god damnit why. interactive check should help at least
end
#ulimit -n 65536 #is persistent and only set in osx

# XXX regular keybind recycling the f/t functionality from vim bindings!
# and prob implement a lil vim-seek 2-char thing for good measure


function __tol_setup_fish_colors
	set -U __tol_setup_fish_colors
	#set all ze colors, bruvbox mode liek.
	
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
set -q __tol_setup_fish_colors; or __tol_setup_fish_colors

setorset -U  __tols_folder_Blue   \U0001f4d8
setorset -U  __tols_folder_Gray   \U0001f4d3
setorset -U  __tols_folder_Green  \U0001f4d7
setorset -U  __tols_folder_None   \U0001f4c1
setorset -U  __tols_folder_Orange \U0001f4d9
setorset -U  __tols_folder_Purple \U0001f47e
setorset -U  __tols_folder_Red    \U0001f4d5
setorset -U  __tols_folder_Yellow \U0001f4d4


# e_check:\u2755\x1e\u2714\x1e\u2753\x1e\u274c\x1e\u2b55\ufe0f\u2b50\ufe0f\U0001f512\x1e\U0001f513                                                                                                                                                                                                                                                                                                                                                                                                                              
# e_clock_half:\U0001f55c\x1e\U0001f55d\x1e\U0001f55e\x1e\U0001f55f\x1e\U0001f560\x1e\U0001f561\U0001f562\x1e\U0001f563\x1e\U0001f564\x1e\U0001f565\x1e\U0001f566\x1e\U0001f567                                                                                                                                                                                                                                                                                                                                                 
# e_clock_whole:\U0001f550\x1e\U0001f551\x1e\U0001f552\x1e\U0001f553\x1e\U0001f554\x1e\U0001f555\x1e\U0001f556\x1e\U0001f557\x1e\U0001f558\x1e\U0001f559\x1e\U0001f55a\x1e\U0001f55b                                                                                                                                                                                                                                                                                                                                            
# e_folder:\U0001f4c1\x1e\U0001f4c2\x1e\U0001f5c2\x1e\U0001f4d5\x1e\U0001f4d7\x1e\U0001f4d8\x1e\U0001f4d9\x1e\U0001f4d4\x1e\U0001f4d2                                                                                                                                                                                                                                                                                                                                                                                           
# e_hands:\U0001f4aa\U0001f3fc\x1e\U0001f448\U0001f3fc\x1e\U0001f449\U0001f3fc\x1e\u261d\ufe0f\U0001f3fc\x1e\U0001f446\U0001f3fc\x1e\U0001f595\U0001f3fc\x1e\U0001f447\U0001f3fc\x1e\u270c\ufe0f\U0001f3fc\x1e\U0001f596\U0001f3fc\x1e\U0001f918\U0001f3fc\x1e\U0001f590\U0001f3fc\x1e\u270a\U0001f3fc\x1e\u270b\U0001f3fc\x1e\U0001f44a\U0001f3fc\x1e\U0001f44c\U0001f3fc\x1e\U0001f44d\U0001f3fc\x1e\U0001f44e\U0001f3fc\x1e\U0001f44b\U0001f3fc\x1e\U0001f44f\U0001f3fc\x1e\U0001f450\U0001f3fc                              
# e_moon:\U0001f315\x1e\U0001f316\x1e\U0001f317\x1e\U0001f318\x1e\U0001f311                                                                                                                                                                                                                                                                                                                                                                                                                                                     
# e_movement_right:\U0001f680\x1e\u2708\ufe0f\x1e\U0001f6e9\x1e\U0001f6f0\x1e\U0001f3f9\x1e\u2604\ufe0f                                                                                                                                                                                                                                                                                                                                                                                                                         
# e_sound:\U0001f507\x1e\U0001f50a\x1e\U0001f509\x1e\U0001f508                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
# e_tech:\u231a\x1e\U0001f4bb\x1e\U0001f5a5\x1e\U0001f4f1\u2328\x1e\U0001f5b1\x1e\U0001f3b9\x1e\U0001f399\x1e\U0001f39a                                                                                                                                                                                                                                                                                                                                                                                                         
# e_time:\u23f3\x1e\u231b\ufe0f\x1e\u23f0\x1e\U0001f4c6                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
# e_util:\U0001f5d1\x1e\U0001f4be\x1e\U0001f4bd\x1e\U0001f50d\x1e\U0001f50e\x1e\U0001f526\x1e\U0001f6a8\x1e\U0001f3c1\x1e\u2699\x1e\U0001f4a1\x1e\U0001f4e6                                                                                                                                                                                                                                                                                                                                                                     
# e_weather:\u2744\ufe0f\x1e\U0001f328\x1e\U0001f4a8\x1e\U0001f32a\x1e\U0001f32b\u2600\ufe0f\x1e\U0001f324\x1e\u26c5\ufe0f\x1e\U0001f325\x1e\U0001f326\x1e\u2601\ufe0f\x1e\U0001f327\x1e\u26c8\x1e\U0001f329\x1e\u26a1\ufe0f\U0001f4a7\x1e\U0001f4a6                                                                                                                                                                                                                                                                            
# emojis_nonshitty:\U0001f4be\x1e\U0001f4bd\x1e\U0001f3b9\x1e\U0001f6a8\x1e\U0001f3c1\x1e\U0001f680\x1e\u231a\x1e\U0001f4bb\x1e\U0001f5b1\x1e\U0001f5a5\x1e\u2328\x1e\U0001f4f1\x1e\U0001f5d1\x1e\U0001f50d\x1e\U0001f50e\x1e\U0001f3f4\x1e\U0001f526\x1e\u2714\x1e\U0001f503\x1e\u2795\x1e\u2796\x1e\u2797\x1e\U0001f4b2\x1e\U0001f553\x1e\U0001f513\x1e\U0001f512\x1e\u2755\x1e\u2753\x1e\U0001f6ab\x1e\u274c\x1e\u2b55\ufe0f\x1e\u23f3\x1e\u231b\ufe0f\x1e\U0001f507\x1e\U0001f50a\x1e\U0001f509\x1e\U0001f508\x1e\U0001f578 




# fish_config_file:/Users/tolgraven/.config/fish/config.fish                                                                                                                                                                                                                                                                                                                                                                                                                                                              
