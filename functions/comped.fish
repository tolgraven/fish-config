function comped --description 'Edit completions inline, based on funced' --argument completename
string match -q -- '-*' "$completename"
and set completename "$argv[-1]"
test -z "$completename"
and echo "completed: You must specify something to complete"
and return 1

set init
set existingcompletions
for i in (seq 1 (count $fish_complete_path))
test -e $fish_complete_path[$i]/$completename.fish
and varadd existingcompletions $fish_complete_path[$i]/$completename.fish
end
set -l IFS # Shadow IFS here to avoid array splitting in command substitution
if type -q $completename
test -z "$existingcompletions[1]"
and set init "complete -c $completename"
or begin
set init (command cat $existingcompletions[1] | fish_indent) #--no-indent) messes up functions w/o indent
test (count $existingcompletions) -gt 1
and echo "found multiple, editing $fish_complete_path[1] (in ~ or you're probably fucking up), saving there either way"
end
end #toled_bind_mode #cant use this now bc too specific. fix better way sometime
set -l prompt "printf '%s%s>\n ' (set_color brgreen) $existingcompletions[1]"
set -l right_prompt (__tol_make_ed_right_prompt comped yellow $completename brgreen)

set -e IFS # Unshadow IFS since the fish_title breaks otherwise   #set -l result #while not set -q comped_exit
if read --prompt "$prompt" --right-prompt "$right_prompt" --command "$init" --shell --mode-name "comped" result
set -l IFS # Shadow IFS _again_ to avoid array splitting
eval (echo -n $result | fish_indent)
or echo \n (set_color red) "UR SHIT's NOT PARSING!" \n (tput smso)"IT MAY BE BORKEN"(tput rmso)
end #end; tol_reload_key_bindings 
if test "$init" = "$result"
echo "No changes detected. Exiting."
return 0
end
set configdir ~/.config/fish
set -q XDG_CONFIG_HOME
and set configdir "$XDG_CONFIG_HOME/fish"
if test (count $existingcompletions) -ge 1 -a -e $existingcompletions[1] #editing existing comp, file writable
set maincomp $existingcompletions[1]
if string match -q "*$XDG_CONFIG_HOME*" "$maincomp" #if in home dir
printf "backing up completion file to %s/%scomped_backups/%s.%s %s because this shit is prob buggy as fuck" (set_color brred)(string replace "$HOME" '~' (dirname $maincomp)) (set_color brpurple) (set_color green) (string replace ".fish" ".bak_fish" (basename $maincomp)) (set_color normal)
cp "$maincomp" (dirname $maincomp)/comped_backups/(string replace ".fish" ".bak_fish" (basename $maincomp))
and echo -ns $result\n >$maincomp
else
echo "Creating parallel completion at $configdir/completions. Yours should take precedence"
echo -ns $result\n >$configdir/completions/$completename.fish
end
else
echo "You compd a comp! Or edited an existing and something went kaputt. but don't worry, nice chill trendy cat>> was used instead of evilbad cat>."\n"Completion written to " (set_color green) $configdir/completions/$completename.fish (set_color normal)
echo -ns $result\n >>$configdir/completions/$completename.fish
end
commandline -f repaint
end
