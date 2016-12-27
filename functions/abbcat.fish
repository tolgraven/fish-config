function abbcat
	set abbrfile ~/.config/fish/conf.d/abbr.fish ~/.config/fish/conf.d/abbr.fish_defs
    if not test -z "$argv"
        grep $argv $abbrfile | fish_indent --ansi
    else
        cat $abbrfile
    end
end
