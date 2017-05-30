function cd --description 'Change directory'
set -l MAX_DIR_HIST 25
if test (count $argv) -gt 1
printf "%s\n" (_ "Too many args for cd command")
return 1
else if status --is-command-substitution # Skip history in subshells.
builtin cd $argv
return $status
end
set -l previous $PWD # Avoid set completions.

if test "$argv" = "-"
if test "$__fish_cd_direction" = "next"
nextd
else
prevd
end
return $status
end
if test -f "$argv" #tol check, if is file
set dir (dirname $argv)
debug "hit file %s, cd to its dir %s" $argv $dir
test -d "$dir"
and set argv $dir
end

builtin cd $argv
set -l cd_status $status
set -l ls (set -lx CLICOLOR_FORCE 1; ls -G)
test (count $ls) -gt 20
and set ls (set -lx CLICOLOR_FORCE 1; echo (set_color red)(count $ls)" files, 20 most recent:"(set_color normal) ' ' (ls -Gtr)[1..20] )

#if test (count $ls) -le 30 #should rather check how many chars, compare to screen width, etc
if status is-interactive
clear_below_cursor
tput cud1
commandline -f repaint
set lslines (math (string length -- "$ls") / $COLUMNS) #+1

echo (set_color -b black)$ls(set_color normal)\ 
tput cuu 2
test $lslines -gt 0
and tput cuu $lslines

end

if test $cd_status -eq 0 -a "$PWD" != "$previous"
set -q dirprev[$MAX_DIR_HIST]
and set -e dirprev[1]
set -g dirprev $dirprev $previous
set -e dirnext
set -g __fish_cd_direction prev
end

return $cd_status
end
