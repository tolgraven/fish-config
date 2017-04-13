function abb --argument abbr expandsto
set -l abbrfile ~/.config/fish/functions/../abbr.fish_defs
echo "abbr $abbr '$expandsto'" >>$abbrfile
and source $abbrfile
end
