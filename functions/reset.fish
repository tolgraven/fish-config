function reset
tput rmcup
tput cnorm

#per http://unix.stackexchange.com/questions/79684/fix-terminal-after-displaying-a-binary-file
stty sane
tput rs1
echo -e "\033c"

#command reset
commandline -f repaint
tol_reload_key_bindings
end
