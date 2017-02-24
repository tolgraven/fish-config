function vim
if type -q nvim
set profile (profile)
switch "$profile"
#case 'vim*' 'hotkey*'
#debug "already vim profile %s, argv %s" $profile $argv
#nvim $argv
case '*'
#itermprofileswitch "nvim" vim $argv #meh why bother tbh. just resets zoom and stuff
#tput smcup #no go, everything glitches out
if status is-interactive
source ~/.config/fish/conf.d/imgcat.fish
echo
imgcat ~/.vim/neovim-logo.png 20 #custom imgcat with height spec
sleep 0.4
nvim $argv
sleep 0.15
move_back_and_kill_lines 21 0.4
#tput cuu 20
#sleep 0.8
#clear_below_cursor
else
nvim $argv
end

end
else
itermprofileswitch "command vim" vim $argv
end

cursor reset
end
