function abbed
	set abbrfile ~/.config/fish/conf.d/abbr.fish_defs #~/.config/fish/conf.d/abbr.fish
    vim $abbrfile
    and source $abbrfile
end
