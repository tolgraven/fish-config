function cd --description 'Change directory'
set -l MAX_DIR_HIST 25
if test (count $argv) -gt 1
printf "%s\n" (_ "Too many args for cd command")
return 1
end
if status --is-command-substitution # Skip history in subshells.
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
test -d "$dir"
and set argv $dir
end

builtin cd $argv
set -l cd_status $status

if test (count (ls)) -le 30 #should rather check how many chars, compare to screen width, etc
and status is-interactive

tput sc #should do like above and then tput cuu x back that many lines, cause this doesnt work towards bottom of terminal...
clear_below_cursor
ls
tput rc
commandline -f repaint
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
