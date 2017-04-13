function abbcat
set abbrfile ~/.config/fish/functions/../abbr.fish_defs #~/.config/fish/conf.d/abbr.fish ~/.config/fish/conf.d/abbr.fish_defs
if not test -z "$argv"
grep $argv $abbrfile | fish_indent --ansi
else
cat $abbrfile | fish_indent --ansi
end
end
