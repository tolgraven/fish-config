function tpm
#switch "$argv"
#case 'update'
~/.config/tmux/plugins/tpm/bin/install_plugins
~/.config/tmux/plugins/tpm/bin/update_plugins all
~/.config/tmux/plugins/tpm/bin/clean_plugins
end
