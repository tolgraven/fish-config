function abbed
set -q tol_fish_abbr_file
and set abbrfile $tol_fish_abbr_file
or set abbrfile ~/.config/fish/functions/../abbr.fish_defs #~/.config/fish/conf.d/abbr.fish_defs #~/.config/fish/conf.d/abbr.fish
not test -z "$argv"
and set -l line (grep --line-number $argv "$abbrfile" | string split -- ':')[1]
debug "search: %s, line: %s" "$argv" $line
vim +$line -c "/$argv" $abbrfile

source $abbrfile
end
