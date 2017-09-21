function background --description 'run fish cmd in bg, via bash shortcut'
#    bash -c "fish -c '""$argv""' &"
bash -c "fish -c eval \"(string escape -- $argv)\" &"
end
