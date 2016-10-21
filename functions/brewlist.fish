function brewlist
	set catcmd cat
type -q ccat
and set catcmd "ccat --color=always"
set -l pipecmd "$catcmd | cgrep -v '.rb' | cgrep --before-context 1 'http'"
tput civis # hide cursor
set -l results (spin "brew search $argv | grep -v homebrew/")
#set descriptions (echo $results\n | parallel brew info)
set -l brews (for res in $results; echo $res | grep -v Caskroom; end)
set -l casks (for res in $results; echo $res | grep Caskroom; end)
#echo $descriptions\n
echo (set_color -o blue)"BREWS:"\t(set_color normal) (echo "$brews" \t | for arg in $argv; cgrep $arg; end)
echo (set_color -o green)"CASKS:" \t(set_color normal) (string replace "Caskroom/" "" "$casks  " | for arg in $argv; cgrep $arg; end)\n
set -l brewlines
set -l casklines
#echo $brews | pr -3 -l1 -t

set brewoutput
set i 1
test (count $brews) -gt 0
and echo (set_color -o blue)"BREWS:"\t(set_color normal)
and for brew in $brews
set name (tint: lightgray "$brew" | for arg in $argv; cgrep $arg; end)
set info (brew info $brew | eval $pipecmd)
#echo (brew desc $brew)\t (tint: blue $info[2])
set brewoutput[$i] (echo $name \t $info[1] \t (test (count $info) -gt 1; and tint: blue $info[2]))
set i (math $i+1)
end
and echo -n -s $brewoutput\n
#columnize brewoutput 3

test (count $casks) -gt 0
and echo \n(set_color -o green)"CASKS:" \t(set_color normal) (string replace "Caskroom/cask/" "" $casks | for arg in $argv; cgrep $arg; end)
and for cask in $casks
set name (inline: (tint: lightgray (string split -r / $cask)[-1])  | for arg in $argv; cgrep $arg; end)
set info (brew cask info $cask | eval $pipecmd)
echo $name \t $info[1] \t (test (count $info) -gt 1; and tint: green $info[2])
end

tput cnorm
end
