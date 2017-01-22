function clone -d "clone git repo from url or gh usr/repo in clipboard"
    set -l repo (pbpaste)
    switch "$repo"
        case 'http*://*' '*www*' '*.com*' '*.git' 'git://*'
            git clone "$repo" $argv | highlight
        case '*'
            hub clone "$repo" $argv | highlight
    end

    cd (ls -t)[1]
end
