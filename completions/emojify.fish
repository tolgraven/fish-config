function __complete_emojify
    if not set -q __emojify_emojis
        set -g __emojify_emojis (string replace --all -- ':' '' (emojify --list | string match --all '* :*' | string trim))
    end
    for line in $__emojify_emojis
        set split (string split -- ' ' $line)
        echo -ns $split[-1] \t ' ' $split[1] '.' \n
    end
end

complete -xc emojify -a '(__complete_emojify)'
