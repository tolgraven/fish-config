function devlastash --description 'List contents of directory, including hidden files in directory using long format'
	set -U tols_filtered_files .DS_Store .Trash .Trashes .DocumentRevisions-V100 .PKInstallSandboxManager .Spotlight-V100 .TemporaryItems .Trashes .com.apple.timemachine .fseventsd .localized \$RECYCLE.BIN #._ #cant have last one bc filters priv functions
    set -g tols_autolabeled_files "Green mp3 wav aif flac asd alp maxpat fxb vst component amdx" "Red zip rar 7z dmg" #etc
    if not type -q grc
        ls -lAhG $argv | for filter in $filters
            grep --color=always -v $filter
        end
        return 0
    end # LATER NAME OF UTIL: tols. get it? ;)
    ###   TODO: !! file size is useless for dirs and filecount useless for non-dirs, so put both in same column...
    set dirname (pwd)
    or return $status

    test (count $argv) -gt 0
    and if test -d $dirname/$argv[-1]
        set dirname $dirname/$argv[-1]
        and set -e argv[-1]
    else if test -d $argv[-1]
        set dirname $argv[-1]
        and set -e argv[-1]
    end
    test (count $argv) -gt 0 # after presumably unsetting dirr part
    and set opts $argv #[1..-2]

    set output (grc -es --colour=on ls -lAhG $opts $dirname)
    test (count $output) -gt 1
    and set firstline $output[1]
    and set output $output[2..-1]

    set items (command ls -A $dirname)
    for filter in $tols_filtered_files
        set items (echo -s -n $items\n | grep --color=always -v $filter)
        set output (echo -s -n $output\n | grep --color=always -v $filter)
    end
    # set -g colorfilters "\$HOME (set_color -o yellow)'~'(set_color normal)" "\$USER (set_color brblue)(string sub -l 4 \$USER)(set_color normal)" '-r "  staff |  admin |  wheel " ""' "' >' (set_color -o red)' >'(set_color grey)" "@ (set_color black)@(set_color normal)" "-r '(20\d\d+)' (set_color black)'\$1'(set_color normal)" ". (set_color brblue)."
    set output (string replace $HOME (set_color -o yellow)'~'(set_color normal) $output) #makes symlinks shorter..
    not string match -q '*root*' $output
    and set output (string replace $USER (set_color brblue)(string sub -l 4 $USER)(set_color normal) $output)
    or set output (string replace $USER (set_color brblue)$USER(set_color normal) $output)
    set output (string replace -r "staff|admin|wheel|_unknown" "" $output) # groups, need better way
    set output (string replace '@' (set_color black)'@'(set_color normal) $output) # xattr
    set output (string replace -r '(20\d\d+)' (set_color black)'\$1'(set_color normal) $output) # years ie old get dimmed
    #set output (string replace --all '.' (set_color black)'.'(set_color brblue) $output) # should add per filetype, same scheme as the labels... also should prob be done per line and from the left only changing the first last part. and/or again before symlink part if symlink.
    #above line needs to go after iconfetch bc color esc fucks string replace
    switch $dirname
        case "*/Applications*"
            set output (string replace "/usr/local/Caskroom" (set_color black)"Cask"(set_color normal) $output)
        case "$HOME*"
            set output (string replace "Google Drive/Mackup" (set_color red)'.ln'(set_color normal) $output)
    end

    #set pattern '(\N\N\d+)($prefixes[$i]+)\s*'; set prefixes B K M G
    #set prefixcolors 'black' '-o bryellow' '-o brred' 'red'; set prefixformat '\ \ \$2' '\ \ \$2'B '\ \ \$2'B '\ \ \$2'B
    #for i in (count $prefixes)
    #set output (string replace -r $pattern '\$1'(set_color $prefixcolors[$i])'$prefixformat[$i]'(set_color normal) $output)
    #eval (echo $pattern); end #issue w below: trips on weird stuff like ++ or whatever in filenames
    set output (string replace -r '(\N\N\d+)(B+)\s*' '\$1'(set_color black)\ \ '\$2'(set_color normal) $output)
    set output (string replace -r '(\N\N\d+)(K+)\s*' '\$1'(set_color bryellow)\ '\$2'B(set_color normal) $output)
    set output (string replace -r '(\N\N\d+)(M+)\s*' '\$1'(set_color -o brred)\ '\$2'B(set_color normal) $output)
    set output (string replace -r '(\N\N\d+)(G+)\s*' '\$1'(set_color red)\ '\$2'B(set_color normal) $output)

    test (count $items) -gt 0
    and test (count $items) -eq (count $output)
    and for i in (seq 1 (count $items))
        set output[$i] (string replace "$items[$i]" (__tols_addicon "$dirname" "$items[$i]")"$items[$i]" "$output[$i]") #could actually run this earlier, so just one call/replace per filetype... then eval.
        #echo (string replace $items[$i] (__tols_addicon $dirname $items[$i] $output[$i])$items[$i] $output[$i])
        set output[$i] (__tols_labelline $dirname $items[$i] $output[$i]) #reformat to addlabel like above i guess bc gonna needa eval...

        echo -s $output[$i]
        breakpoint
    end
    set output (string replace '>' (set_color -o red)'>'(set_color grey) $output) # symlinks

    #echo -n -s $output\n
    return 0
end
