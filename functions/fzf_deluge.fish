function fzf_deluge
#set -l fzfopts "--height='40%' --preview='deluge info' --preview-window=right:20 bind 'enter:execute/usr/local/bin/fish -c {}'"
set -l extracmds clip\t'add from clipboard' watch\t'run info continuously'
set -l cmds $extracmds (complete -C"deluge ")
echo -ns $cmds\n | strip_empty_lines | fish_indent --ansi | fzf --height=60% --preview='deluge_latest' --preview-window=right:70% --bind 'enter:execute:/usr/local/bin/fish -c deluge {} > /Users/tolgraven/.cache/deluge_fzf'
#"$fzfopts"
end
