function __tol_list_killring
set -l num 5
commandline_save list_killring
commandline ''
commandline -f yank
for i in (seq 1 $num)
commandline -f yank-pop
set killring $killring (commandline)
debug "killring: $killring"
end

commandline_restore list_killring
echo $killring
end
