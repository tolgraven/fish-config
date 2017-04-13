function setorset -a flags var values
	test (count $argv) -ge 3;  or return 1
	if not set -q $var;  set $flags $var $argv[3..-1];  end
end

setorset -U fish_escape_delay_ms 		100
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

setorset -U tol_fish_abbr_file 	~/.config/fish/functions/../abbr.fish_defs
test (count (abbr -l)) -eq (count (command cat $tol_fish_abbr_file)); or source $tol_fish_abbr_file

setorset -Ux XDG_CONFIG_HOME 	"$HOME/.config"
setorset -Ux XDG_DATA_HOME   	"$HOME/.local/share"
setorset -Ux XDG_CACHE_HOME  	"$HOME/.cache"
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
setorset -Ux BYOBU_PREFIX 		(brew --prefix)
setorset -Ux TMUX_PLUGIN_MANAGER_PATH "$XDG_CONFIG_HOME/tmux/plugins"
setorset -Ux GOOGLER_COLORS 	"MEnhxI" #bBblue i, bblue titles, brpurple links, white text etc

setorset -U  nfssettings 			"nolocks,locallocks,intr,soft,wsize=32768,rsize=32768,proto=tcp"
setorset -U  rsyncopts  				--human-readable --info=progress2 --recursive --times --perms --compress --links
setorset -U  tolmenu_actions 	'auto_desc' 'debug_on' 'debug_off' 'debug_token' 'debug_notoken'
setorset -U  grc_wrap_commands cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff  #skip ls for tols, and cat for ccat/vimcat et al

switch (hostname)
	case absurd
		# eval (docker-machine env default ^&-) #)^ /dev/null)
		status is-interactive; and source (rbenv init -|psub) 	#ruby rbenv

		set -g stderred_path 			~/.local/lib/libstderred.dylib 	#no check, so dont get outdated hanging aroudn if change
		setorset -Ux STDERRED_BLACKLIST "fzf|lnav|htop|tmux|zsh|brew|go|mosh|ssh"
		__stderred startup
end

type -q autojump; and test -f (dirname (which autojump))/../share/autojump/autojump.fish; and source (dirname (which autojump))/../share/autojump/autojump.fish #more generic like
test -z (which env_parallel.fish);  or source (which env_parallel.fish) #GNU parallel shell support
eval (python -m virtualfish)
test -n "$DESK_ENV"; and source "$DESK_ENV"; or true
# type -q thefuck;              and eval (thefuck --alias | tr '\n' ';') #fucking startup performance a bit?
#ulimit -n 65536 #is persistent and only set in osx

