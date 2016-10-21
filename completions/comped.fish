complete -c comped -n "__fish_is_token_n 2" -a '(echo -s -n (functions)\t"func"\n; for dir in $PATH; echo -s -n (ls -1 $dir)\t(string replace $HOME "~" $dir)\n; end)' -fr
#complete -xc comped -n '__fish_is_token_n 3' -a '(echo -s -n (ls -1 ~/.config/fish/completions)\t"completed"\n | grep ".fish" | string replace ".fish" "")'
complete -c comped -r -s u -l in-user-folder -d "only list already defined user completions" -a '(echo -s -n (ls -1 ~/.config/fish/completions)\t"comp"\n | grep ".fish" | grep -v "bak_fish" | string replace ".fish" "")' -f #lalal
complete -c comped -s n -d "number of empty completion starter lines to add"
