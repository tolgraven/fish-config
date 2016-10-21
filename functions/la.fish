function la --description 'List contents of directory, including hidden files in directory using long format'
	set -U tols_filtered_files .DS_Store .Trash .Trashes .DocumentRevisions-V100 .PKInstallSandboxManager .Spotlight-V100 .TemporaryItems .Trashes .com.apple.timemachine .fseventsd .localized \$RECYCLE.BIN .IABootFiles .IAProductInfo
    set -g tols_autolabeled_files "Green mp3 wav aif flac asd alp maxpat fxb vst component amdx" "Red zip rar 7z dmg" #etc
    if not type -q grc
        ls -lAhG $argv | for filter in $filters
            grep --color=always -v $filter
        end
        return 0
    end #TODO: size useless f dirs, count ditto f non-dirs, share column. MORE: special listing for /Volumes w drive icos and /Icon support, plus show capacity/used from df!!
    set dirname (pwd)
    or return $status

    test (count $argv) -gt 0
    and if test -d $dirname/$argv[-1]
        set dirname $dirname/$argv[-1]
        and set -e argv[-1]
    else if test -d $argv[-1]
        or test -r $argv[1] #pass through also if a file so doesn't grab entire dir...
        set dirname $argv[-1]
        and set -e argv[-1]
    end
    test (count $argv) -gt 0 # after presumably unsetting dirr part
    and set opts $argv

    set output (grc -es --colour=on ls -lAhG $opts $dirname)
    test (count $output) -gt 1
    and set firstline $output[1]
    and set output $output[2..-1]
    set items (command ls -A $dirname)
    for filter in $tols_filtered_files
        set items (echo -s -n $items\n | grep --color=always -v $filter)
        set output (echo -s -n $output\n | grep --color=always -v $filter)
    end

    set output (string replace -- $HOME (set_color -o yellow)'~'(set_color normal) $output) #makes symlinks shorter..
    not string match -q -- '*root*' $output
    and set output (string replace -- $USER (set_color brblue)(string sub -l 4 $USER)(set_color normal) $output)
    or set output (string replace -- $USER (set_color brblue)$USER(set_color normal) $output)
    set output (string replace -r -- "staff|admin|wheel|_unknown|501|502|503" "" $output) # groups, need better way
    set output (string replace -- '@' (set_color black)'@'(set_color normal) $output) # xattr
    set output (string replace -r -- '(20\d\d+)' (set_color black)'\$1'(set_color normal) $output) # years ie old get dimmed
    set output (string replace --all -- '.' (set_color black)'.'(set_color brblue) $output) # should add per filetype, same scheme as labels... also should prob be done per line and from left only changing the first-last part. and again before symlink
    switch $dirname
        case "*/Applications*"
            set output (string replace -- "/usr/local/Caskroom" (set_color black)"Cask"(set_color normal) $output)
        case "$HOME*"
            set output (string replace -- "Google Drive/Mackup" (set_color red)'.ln'(set_color normal) $output)
    end
    set output (string replace -r -- '(\N\N\d+)(B+)\s*' '\$1'(set_color black)\ \ '\$2'(set_color normal) $output)
    set output (string replace -r -- '(\N\N\d+)(K+)\s*' '\$1'(set_color bryellow)\ '\$2'B(set_color normal) $output)
    set output (string replace -r -- '(\N\N\d+)(M+)\s*' '\$1'(set_color -o brred)\ '\$2'B(set_color normal) $output)
    set output (string replace -r -- '(\N\N\d+)(G+)\s*' '\$1'(set_color red)\ '\$2'B(set_color normal) $output)

    test (count $items) -gt 0
    and test (count $items) -eq (count $output)
    and for i in (seq 1 (count $items))
        set fullpath $dirname/"$items[$i]"
        if test -d $fullpath
            and test -f $fullpath
            set label (get_label "$fullpath" terminal ^&-) #absolutely should parallelize this! would be hella faster...

            test $label = 'None'
            and set label 'normal'
        else
            continue # lil bit of optimization for now
        end
        test $label = 'normal'
        and switch $items[$i]
            case bin sbin exec Applications MacOS
                set label "brred"
            case "*lib" "lib*" src include headers "node*" python "*.git*" "function*"
                set label "purple"
            case "share" "man"
                set label "yellow"
            case "*.vst" "*.component" "ableton*"
                set label "green"
        end
        set relevantpart (string split -r -m 2 -- . "$items[$i]")[1]
        test -z $relevantpart
        and set relevantpart (string sub -s 2 -- "$items[$i]") #reset filepart to entire file if dotfile
        set output[$i] (string replace -- "$relevantpart" (set_color $label)"$relevantpart"(set_color normal) "$output[$i]" ^&-) ^&-
    end
    set output (string replace -- '>' (set_color -o red)'>'(set_color grey) $output) # symlinks
    echo -s -n $output\n
    #return 0
end
