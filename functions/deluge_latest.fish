function deluge_latest --description 'deluge preview callback'
test -z "$deluge_action"
and set deluge_action "deluge info"
#eval $deluge_action
if test -f ~/.cache/deluge_fzf
cat ~/.cache/deluge_fzf
and rm ~/.cache/deluge_fzf
else
eval $deluge_action
end
end
