function vim
#if status --is-interactive
if type -q nvim
set profile (profile)
switch "$profile"
case 'vim*' 'hotkey*'
debug "already vim profile %s, argv %s" $profile $argv
nvim $argv
case '*'
#itermprofileswitch "nvim" vim $argv #meh why bother tbh. just resets zoom and stuff
imgcat ~/.vim/neovim-logo.png
nvim $argv
tput cuu 20 #sizse of logo
clear_below_cursor
end
else
itermprofileswitch "command vim" vim $argv
end

cursor reset
end
