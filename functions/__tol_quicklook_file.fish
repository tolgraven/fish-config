function __tol_quicklook_file
    #realpath (commandline --current-token) | read -l path
    commandline --current-token | string replace '~' $HOME | string replace '\\' '' | read -l path
    debug "$path"
    test -r "$path"
    and ql "$path"
    switch (profile)
        case 'hotkey*'
            sleep 3

            #osascript -e "tell application \"iTerm2\" to tell current window to select" #activate"
    end
end
