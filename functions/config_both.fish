function config_both
vim ~/.config/fish/conf.d/init_joen.config.fish -c ":vsp $HOME/.config/fish/config.fish"
source ~/.config/fish/conf.d/init_joen.config.fish
source $HOME/.config/fish/config.fish
end
