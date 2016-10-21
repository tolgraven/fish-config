function configure_pager --description 'Run once for color glory'
	# Colored man pages: http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages
    set -Ux LESS_TERMCAP_mb \e'[01;31m' # begin blinking
    set -Ux LESS_TERMCAP_md \e'[01;38;5;74m' # begin bold
    set -Ux LESS_TERMCAP_me (tput sgr0) #\e'[0m' # end mode
    set -Ux LESS_TERMCAP_so (tput smso) #\e'[38;5;016m\E[48;5;220m' # begin standout-mode - info box
    set -Ux LESS_TERMCAP_se (tput rmso) #\e'[0m' # end standout-mode
    set -Ux LESS_TERMCAP_us (tput us; tput setaf 9) #(tput us) #\e'[04;38;5;146m' # begin underline
    set -Ux LESS_TERMCAP_ue (tput sgr0) # or rmul #\e'[0m' # end underline
end
