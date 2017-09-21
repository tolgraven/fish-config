function vim
if type -q nvim
set profile (profile)
#        switch "$profile"
#case 'vim*' 'hotkey*'
#debug "already vim profile %s, argv %s" $profile $argv
#            case '*'
if status is-interactive
#and not status is-command-substitution
#                    if not test "$TMUX"
source ~/.config/fish/conf.d/imgcat.fish
echo
imgcat ~/.vim/neovim-logo.png
sleep 0.15
kill -28 %self #sigwinch
#                    end
#                    set session_index (contains -i -- -S $argv)
#                    and set -gx LISTEN_ADDR /tmp/$argv[$session_index]_nvim_sock
#                    test -r "$LISTEN_ADDR"
#                    and set -gx LISTEN_ADDR /tmp/(tty)_nvim_sock #(mktemp)
debug "argv %s, session index pow if any %s, listen_addr %s" "$argv" "$session_index" $LISTEN_ADDR
nvim $argv #-c 'so "$MYVIMRC"' # ' so var not expanded by shell

if not test "$TMUX"
sleep 0.05
move_back_and_kill_lines 21 0.4 #clear_below_cursor
end
#                else
#                    nvim $argv
#                end
end
else
itermprofileswitch "command vim" vim $argv
end
cursor reset
end
