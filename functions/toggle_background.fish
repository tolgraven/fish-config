function toggle_background --description 'system-wide (menu/dock, iterm, tmux, vim) dark/light bg toggle' --argument new
set -U background $new
defaults write -g AppleInterfaceTheme -string $new
defaults write -g AppleInterfaceStyle -string $new

#TODO:
#disable deluminate, in chrome
#disable stylish, chrome/safari
#find all iterm panes of "standard" profile and switch to standard-bright
#find socket of all nvim instances, tellem
#tell tmux to source alt statusline.tmux?
#### todo make actual light theme...
end
