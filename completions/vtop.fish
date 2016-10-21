set themes "acid becca brew dark monokai parallax seti wizard"
complete -xc vtop -s t -l theme -a '(echo -s -n (string split " " $themes)\t"theme"\n)'
